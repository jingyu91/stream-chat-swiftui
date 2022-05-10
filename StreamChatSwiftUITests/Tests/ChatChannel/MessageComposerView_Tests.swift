//
// Copyright © 2022 Stream.io Inc. All rights reserved.
//

import SnapshotTesting
@testable import StreamChat
@testable import StreamChatSwiftUI
import XCTest

class MessageComposerView_Tests: StreamChatTestCase {
    
    override func setUp() {
        super.setUp()
        let utils = Utils(
            messageListConfig: MessageListConfig(becomesFirstResponderOnOpen: true)
        )
        streamChat = StreamChat(chatClient: chatClient, utils: utils)
    }

    func test_messageComposerView_snapshot() {
        // Given
        let factory = DefaultViewFactory.shared
        let channelController = ChatChannelTestHelpers.makeChannelController(chatClient: chatClient)
                
        // When
        let view = MessageComposerView(
            viewFactory: factory,
            channelController: channelController,
            messageController: nil,
            quotedMessage: .constant(nil),
            editedMessage: .constant(nil),
            onMessageSent: {}
        )
        .frame(width: defaultScreenSize.width, height: 100)

        // Then
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_composerInputView_slowMode() {
        // Given
        let factory = DefaultViewFactory.shared

        // When
        let view = ComposerInputView(
            factory: factory,
            text: .constant(""),
            selectedRangeLocation: .constant(0),
            command: .constant(nil),
            addedAssets: [],
            addedFileURLs: [],
            addedCustomAttachments: [],
            quotedMessage: .constant(nil),
            cooldownDuration: 15,
            onCustomAttachmentTap: { _ in },
            removeAttachmentWithId: { _ in }
        )
        .frame(width: defaultScreenSize.width, height: 100)
        
        // Then
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_trailingComposerView_snapshot() {
        // Given
        let factory = DefaultViewFactory.shared
        
        // When
        let view = factory.makeTrailingComposerView(
            enabled: true,
            cooldownDuration: 0,
            onTap: {}
        )
        .frame(width: 40, height: 40)
        
        // Then
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_trailingComposerView_slowMode() {
        // Given
        let factory = DefaultViewFactory.shared
        
        // When
        let view = factory.makeTrailingComposerView(
            enabled: true,
            cooldownDuration: 15,
            onTap: {}
        )
        .frame(width: 40, height: 40)
        
        // Then
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_composerInputView_inputTextView() {
        // Given
        let view = InputTextView(
            frame: .init(x: 16, y: 16, width: defaultScreenSize.width - 32, height: 50)
        )
        
        // When
        view.text = "This is a sample text"
        view.selectedRange.location = 3
        
        // Then
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_composerInputView_composerInputTextView() {
        // Given
        let view = ComposerTextInputView(
            text: .constant("This is a sample text"),
            height: .constant(38),
            selectedRangeLocation: .constant(3),
            placeholder: "Send a message",
            editable: true
        )
        .frame(width: defaultScreenSize.width, height: 50)
                
        // Then
        assertSnapshot(matching: view, as: .image)
    }
}
