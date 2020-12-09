//
//  NewProjectView.swift
//  crelo
//
//  Created by michelle gleed on 11/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI

struct NewProjectView: View {
    
    @Binding var tabBarSelection: Int
    @State var project: ConfirmNewProject? = nil
    
    func resetView () {
        project = nil
    }
    
    var body: some View {
        return Group {
        if project != nil {
            ProjectDetail(projectId: project?.id, project: nil)
                .onDisappear(perform: resetView)
            
        }
        else {
            NewProjectForm(project: $project)
        }
        }
    }
}


//struct NewProject_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProjectView()
//    }
//}
