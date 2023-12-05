//
//  StatSheet.swift
//  TEST
//
//  Created by Chris Plowman on 12/3/23.
//

import SwiftUI

struct StatSheet: View {
    @ObservedObject var viewModel: ApiViewModel
    @State var GoalSheet = false
    var body: some View {
        VStack {
            Text("Goals")
                .foregroundColor(CustomTeal.MyTeal)
                .font(.system(size: 30))
                .padding()
            
            ProgressView(value: viewModel.weeklyCals, total: viewModel.goalCals) {
                Text("\(String(format: "%.2f", viewModel.weeklyCals))cal. / \(String(format: "%.2f", viewModel.goalCals))cal.")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklyFats, total: viewModel.goalFats) {
                Text("\(String(format: "%.2f", viewModel.weeklyCals))cal. / \(String(format: "%.2f", viewModel.goalFats))cal.")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklyProtein, total: viewModel.goalProtein) {
                Text("\(String(format: "%.2f", viewModel.weeklyProtein))g / \(String(format: "%.2f", viewModel.goalProtein))g")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklySodium, total: viewModel.goalSodium) {
                Text("\(String(format: "%.2f", viewModel.weeklySodium))mg / \(String(format: "%.2f", viewModel.goalSodium))mg")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklyCholest, total: viewModel.goalCholest) {
                Text("\(String(format: "%.2f", viewModel.weeklyCholest))mg / \(String(format: "%.2f", viewModel.goalCholest))mg")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklyCarbs, total: viewModel.goalCarbs) {
                Text("\(String(format: "%.2f", viewModel.weeklyCarbs))g / \(String(format: "%.2f", viewModel.goalCarbs))g")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()

            ProgressView(value: viewModel.weeklySugars, total: viewModel.goalSugars) {
                Text("\(String(format: "%.2f", viewModel.weeklySugars))g / \(String(format: "%.2f", viewModel.goalSugars))g")
                    .foregroundColor(Color.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .padding()
            
            Button("Edit Goals") {
                GoalSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(Color.black)
            .tint(CustomTeal.MyTeal)
            .controlSize(.large)
            .sheet(isPresented: $GoalSheet) {
                GoalEditScreen(viewModel: ApiViewModel())
                    .background(Color.gray)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Goals_Previews: PreviewProvider {
    static var previews: some View {
        StatSheet(viewModel: ApiViewModel()).background(Color.gray)
    }
}
