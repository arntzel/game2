//
//  BFViewController.h
//  SixBeans
//
//  Created by Eliot Arntz on 10/28/12.
//  Copyright (c) 2012 Eliot Arntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFViewController : UIViewController
<UIGestureRecognizerDelegate>


//ivars
@property int numberOfPiecesOnBoard;
@property UIColor *tileColor;

@property (nonatomic) BOOL whitesTurn;
@property (nonatomic) BOOL gameStarted;

@property (strong, nonatomic) NSArray *possibleMovesArray;


//Contains all tiles created in the loadSubView method
@property (strong, nonatomic) NSMutableArray *tiles;
@property (strong, nonatomic) NSMutableArray *currentPlayerTiles;
@property (strong, nonatomic) NSMutableArray *blackTiles;
@property (strong, nonatomic) NSMutableArray *whiteTiles;
@property (strong, nonatomic) NSMutableArray *activePiecesLocationOnBoard;


//Methods

-(void)blackPlayer;
-(void)whitePlayer;
-(void)playerTurn;
-(void)pregameSetup;

//-loads the button layout for the game and sets the background.
-(void)loadSubView;

@end
