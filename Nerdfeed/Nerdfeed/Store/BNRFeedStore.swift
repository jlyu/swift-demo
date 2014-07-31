//
//  BNRFeedStore.swift
//  Nerdfeed
//
//  Created by chain on 14-7-22.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class BNRFeedStore: NSObject {
    
    
    // - Singleton
    
    struct Static {
        static var token: dispatch_once_t = 0
        static var sharedStore: BNRFeedStore?
    }
    
    class var sharedStore: BNRFeedStore {
        dispatch_once(&Static.token) { Static.sharedStore = BNRFeedStore() }
        return Static.sharedStore!
    }
    
    init() {
        super.init()
        
        if self != nil {
            model = NSManagedObjectModel.mergedModelFromBundles(nil)
            var persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            
            var err: NSError? = nil
            var dbPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
                            NSSearchPathDomainMask.UserDomainMask, true)[0] as String
            dbPath = dbPath.stringByAppendingPathComponent("feed.db")
            var dbURL = NSURL(fileURLWithPath: dbPath)
            
            if !persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
                                                URL: dbURL, options: nil, error: &err) {
                    println("Error: \(err!.localizedDescription)")
            }
            
            context = NSManagedObjectContext()
            context.persistentStoreCoordinator = persistentStoreCoordinator
            context.undoManager = nil
        }
    }
    
    
    // - Properties
    
    var context: NSManagedObjectContext!
    var model: NSManagedObjectModel!
    
    
    var topSongsCacheDate: NSDate? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("topSongsCacheDate") as? NSDate
        }
        set(newCacheDate) {
            NSUserDefaults.standardUserDefaults().setObject(newCacheDate, forKey: "topSongsCacheDate")
        }
    }
    
    
    
    // - Method
    
    
    //typealias fetchRSSFeedWithCompletionHandler = (obj: RSSChannel!, err: NSError!) -> Void
    func fetchRSSFeedWithCompletion(completionBlock block: (obj: RSSChannel!, err: NSError!) -> Void) -> RSSChannel {
        
        var cachePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory,
                                    NSSearchPathDomainMask.UserDomainMask,true)[0] as String
        cachePath = cachePath.stringByAppendingPathComponent("nerd.archive")
        // cached nerd RSSChannel Data
        var cachedChannel = NSKeyedUnarchiver.unarchiveObjectWithFile(cachePath) as? RSSChannel
        if !cachedChannel {
            cachedChannel = RSSChannel() // new
        }
        
        var channelCopy: RSSChannel = cachedChannel?.copy() as RSSChannel
        
        
        let requestURL = NSURL(string: "http://forums.bignerdranch.com/smartfeed.php?limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT")
        let request = NSURLRequest(URL: requestURL)
        var connection: BNRConnection = BNRConnection(request: request)
        var channel = RSSChannel()
        
        
        connection.completionBlock = { obj, err in
            if err == nil {
                //cachedChannel!.addItemsFromChannel(obj)
                channelCopy.addItemsFromChannel(obj)
                //NSKeyedArchiver.archiveRootObject(cachedChannel, toFile: cachePath)
                NSKeyedArchiver.archiveRootObject(channelCopy, toFile: cachePath)
            }
            
            block(obj: channelCopy, err: err)
        }
        
        connection.xmlRootObject = channel
        connection.start()
        
        return cachedChannel!
    }
    
    
    func fetchTopSongs(#count: Int, withCompletion block: (obj: RSSChannel!, err: NSError!)->Void ) {
        
        var cachePath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory,
                                    NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        cachePath = cachePath.stringByAppendingPathComponent("apple.archive")
        
        
        let requestString = "http://itunes.apple.com/jp/rss/topsongs/limit=\(count)/json" // <- xml
        let URL = NSURL(string: requestString)
        let request = NSURLRequest(URL: URL)
        
        var channel = RSSChannel()
        var connection = BNRConnection(request: request)
        
        // load cache
        if self.topSongsCacheDate {
            var cacheInterval = self.topSongsCacheDate!.timeIntervalSinceNow
            if cacheInterval > -300 {
                println("load topSongs cache")
                var cacheChannel = NSKeyedUnarchiver.unarchiveObjectWithFile(cachePath) as RSSChannel
                if cacheChannel != nil {
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({() in
                        block(obj: cacheChannel, err: nil)
                    })

                    return
                }
            }
        }
        
        
        connection.completionBlock =  { obj, err in
            if err == nil {
                self.topSongsCacheDate = NSDate()
                NSKeyedArchiver.archiveRootObject(obj, toFile: cachePath)
            }
            block(obj: obj, err: err)
        }

        
        connection.jsonRootObject = channel
        
        connection.start()
    }


    func markItemAsRead(item: RSSItem) {
        if hasItemBennRead(item) {
            return
        }
        
        var obj: NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Link",
                                                        inManagedObjectContext: context) as NSManagedObject
        obj.setValue(item.link, forKey: "urlString")
        context.save(nil)
    }
    
    
    func hasItemBennRead(item: RSSItem) -> Bool {
        
        var request: NSFetchRequest = NSFetchRequest(entityName: "Link")
        var predicate = NSPredicate(format: "urlString like \(item.link)")
        request.predicate = predicate
        
        var entries = context.executeFetchRequest(request, error: nil)
        if entries.count > 0 {
            return true
        }
        
        return false
    }
    
    
}
