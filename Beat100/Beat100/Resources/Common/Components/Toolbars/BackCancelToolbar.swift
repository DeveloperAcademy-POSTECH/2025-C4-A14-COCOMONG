//
//  BackCancel.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct BackCancelToolbar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            BackButton(action: {
                dismiss()
            })
            Spacer()
            CancelButton(action: {
                isPresented = false
            })
        }
        .padding(.leading, 4)
        .padding(.trailing, 16)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CancelToolbar: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            CancelButton(action: {
                isPresented = false
            })
        }
        .padding(.leading, 4)
        .padding(.trailing, 16)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct BackToolbar: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            BackButton(action: {
                dismiss()
            })
            Spacer()
        }
        .padding(.leading, 4)
        .padding(.trailing, 16)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

private struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.beatTeal)
                
                Text("뒤로")
                    .font(.system(size: 17))
                    .foregroundColor(.beatTeal)
            }
            .padding(.leading, 8)
            .padding(.vertical, 11)
        }
    }
}

private struct CancelButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("취소")
                .font(.system(size: 17))
                .foregroundColor(.beatTeal)
                .padding(.leading, 8)
                .padding(.vertical, 11)
        }
    }
}

#Preview {
    BackCancelToolbar(isPresented: .constant(true))
    CancelToolbar(isPresented: .constant(true))
    BackToolbar()
}
