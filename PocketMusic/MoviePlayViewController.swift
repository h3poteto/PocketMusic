//
//  MoviePlayViewController.swift
//  PocketMusic
//
//  Created by akirafukushima on 2014/08/19.
//  Copyright (c) 2014年 interfirm. All rights reserved.
//

import UIKit
import MediaPlayer

class MoviePlayViewController: UIViewController {
    
    var youtubeMovieURL: NSURL!
    var webView: UIWebView!
    var youtubeMovieId: NSString!
    
    // クラス変数が未実装のため構造体で対応
    private struct SharedStruct {
        static var _sharedClient: MoviePlayViewController!
    }
    
    //=========================================
    //  class method
    //=========================================
    class func sharedClient() -> MoviePlayViewController {
        if (SharedStruct._sharedClient == nil) {
            SharedStruct._sharedClient = MoviePlayViewController()
        }
        
        return SharedStruct._sharedClient
    }
    
    //=========================================
    //  instance method
    //=========================================
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.youtubeMovieId = "zE7TF09EKk4"
    }
    
    override init() {
        super.init()
    }
    
    init(movieId: NSString) {
        super.init()
        
        self.youtubeMovieId = movieId
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        let WindowSize = UIScreen.mainScreen().bounds
        var jsonError: NSError?
        var movieWidth: CGFloat!
        var movieHeight: CGFloat!
        if (self.youtubeMovieId != nil) {
        
            // get youtube movie data
            var parse_url = NSURL.URLWithString("http://www.youtube.com/oembed?url=" + "http://www.youtube.com/watch?v=" + self.youtubeMovieId + "&format=json")
            let parse_request = NSURLRequest(URL: parse_url)
            NSURLConnection.sendAsynchronousRequest(parse_request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response, data, error) in
                var result:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as NSDictionary
                movieWidth = result.objectForKey("width") as CGFloat
                movieHeight = result.objectForKey("height") as CGFloat

                self.youtubeMovieURL = NSURL.URLWithString("http://www.youtube.com/embed/" + self.youtubeMovieId)
                self.webView = UIWebView(frame: CGRectMake(0, self.navigationController.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height, WindowSize.size.width, WindowSize.size.width * movieHeight / movieWidth))
                var request = NSURLRequest(URL: self.youtubeMovieURL)
                self.view.addSubview(self.webView)
                self.webView.loadRequest(request)
            })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
