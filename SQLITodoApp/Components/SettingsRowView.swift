//
//  SettingsRowView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12, content: {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        })
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "version", tintColor: Color(.systemGray))
}
