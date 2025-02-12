//
//  ViewController.swift
//  test_depth_stencil_state_cache_ios
//
//  Created by Yousif on 06/02/2025.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    
    let mtlView = MTKView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mtlView)
        
        mtlView.delegate = self
        mtlView.device = MTLCreateSystemDefaultDevice()
        print(mtlView.device)
    }
}

var dict: [Int: MTLDepthStencilState] = [:]

extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    func draw(in view: MTKView) {
        var prev = 0
        var t = 0, f = 0
        for i in 1...1000000 {
            let descriptor = MTLDepthStencilDescriptor()
            descriptor.isDepthWriteEnabled = true
            let state = view.device?.makeDepthStencilState(descriptor: descriptor)
            let ptr = Unmanaged<AnyObject>.passUnretained(state as AnyObject).toOpaque()
            let k = Int(bitPattern: ptr)
            if prev == k {
                t += 1
            } else {
                f += 1
            }
//            print("prev", prev, "k", k, "i", i)
            prev = k
            dict[i] = state
        }
        print("t", t, "f", f)
    }
}
