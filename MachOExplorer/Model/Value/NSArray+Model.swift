//----------------------------------------------------------------------------//
//|
//|             MachOExplorer - A Graphical Mach-O Viewer
//! @file       NSArray+Model.swift
//!
//! @author     D.V.
//! @copyright  Copyright (c) 2018 D.V. All rights reserved.
//|
//| Permission is hereby granted, free of charge, to any person obtaining a
//| copy of this software and associated documentation files (the "Software"),
//| to deal in the Software without restriction, including without limitation
//| the rights to use, copy, modify, merge, publish, distribute, sublicense,
//| and/or sell copies of the Software, and to permit persons to whom the
//| Software is furnished to do so, subject to the following conditions:
//|
//| The above copyright notice and this permission notice shall be included
//| in all copies or substantial portions of the Software.
//|
//| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//| OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//| MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//| IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//| CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//| TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//| SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//----------------------------------------------------------------------------//

import MachOKit

extension NSArray /* OutlineModel */
{
    override var outline_nodes: [OutlineNodeModel] {
        return (self as! [NSObject]).reduce([], { $0 + $1.outline_nodes })
    }
}

extension NSArray /* DetailModel */
{
    override var detail_rows: [DetailRowModel] {
        if self.count < 1 {
            return [];
        }
        
        var detailRowModels = Array<DetailRowModel>()
        
        // Optimization - Ask the first item for its detail_rows, assume that
        // the detail_rows of every item will contain the same number of
        // DetailRowModel objects.
        let reserveCapacity = self.count * (self[0] as! NSObject).detail_rows.count;
        detailRowModels.reserveCapacity(reserveCapacity);
        
        for item in self {
            detailRowModels += (item as! NSObject).detail_rows;
        }
        
        return detailRowModels;
    }
}
