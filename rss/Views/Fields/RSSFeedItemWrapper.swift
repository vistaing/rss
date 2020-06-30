//
//  RSSItem.swift
//  rss
//
//  Created by 谷雷雷 on 2020/6/28.
//  Copyright © 2020 acumen. All rights reserved.
//

import Foundation
import Combine
import CoreData
import FeedKit

protocol RSSItemConvertable {
    func asRSSItem(container uuid: UUID, in context: NSManagedObjectContext) -> RSSItem
}

extension RSSFeedItem: RSSItemConvertable {
    func asRSSItem(container uuid: UUID, in context: NSManagedObjectContext) -> RSSItem {
        return RSSItem.create(uuid: uuid, title: title, desc: description, author: author, url: link, createTime: pubDate, in: context)
    }
}

extension AtomFeedEntry: RSSItemConvertable {
    func asRSSItem(container uuid: UUID, in context: NSManagedObjectContext) -> RSSItem {
        return RSSItem.create(uuid: uuid, title: title, desc: nil, author: authors?.first?.name, url: links?.first?.attributes?.href, createTime: published ?? updated, in: context)
    }
}

extension JSONFeedItem: RSSItemConvertable {
    func asRSSItem(container uuid: UUID, in context: NSManagedObjectContext) -> RSSItem {
        return RSSItem.create(uuid: uuid, title: title, author: author?.name, url: url, createTime: datePublished, in: context)
    }
}
