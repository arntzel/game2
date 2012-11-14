//
//  BFViewController.m
//  SixBeans
//
//  Created by Eliot Arntz on 10/28/12.
//  Copyright (c) 2012 Eliot Arntz. All rights reserved.
//

#import "BFViewController.h"

@interface BFViewController ()
@end

@implementation BFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //initialize and assign relevant ivars
    _currentPlayerTiles = [[NSMutableArray alloc] init];
    _whiteTiles = [[NSMutableArray alloc] init];
    _blackTiles = [[NSMutableArray alloc] init];
    _possibleMovesArray = @[
    // horizontal grouping
    @[@0,@1,@2],@[@3,@4,@5],@[@6,@7,@8],@[@9,@10,@11],
    @[@12,@13,@14],@[@15,@16,@17],@[@18,@19,@20],@[@21,@22,@23],
    // vertical grouping
    @[@0,@9,@21],@[@3,@10,@18],@[@6,@11,@15],@[@1,@4,@7],
    @[@16,@19,@22],@[@8,@12,@17],@[@5,@13,@20],@[@2,@14,@23]];
    // diagnol grouping
    //@[@0,@3,@6],@[@2,@5,@8],@[@21,@18,@15],@[@23,@20,@17]];
    
    
    //load custom subview
    [self loadSubView];
    //start game with white
    _whitesTurn = YES;
    //run turn based game
    [self playerTurn];
    
    
}

-(void)playerTurn{
    //Step 1 Determine and set the color of tiles to be used
    if (_whitesTurn == YES){
        [self whitePlayer];
        
    }
    else{
        [self blackPlayer];
    }
    
    //Step 2 determine if we are in setup mode or game play mode
    if (_gameStarted != YES){
        [self pregameSetup];
    }
    
    //rerun the whitePlayer/blackPlayer methods to update the current tiles array

}

-(void)whitePlayer{
    NSLog(@"white's turn");
    _tileColor = [UIColor whiteColor];
    _currentPlayerTiles = _whiteTiles;
}

-(void)blackPlayer{
    NSLog(@"black's turn");
    _tileColor = [UIColor blackColor];
    _currentPlayerTiles = _blackTiles;
}

-(void)loadSubView{
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"macBackGround.png"]];
    self.view.backgroundColor = background;
    
    UIImage *woodenBlock = [UIImage imageNamed:@"woodSquare.png"];
    
    //x and y coordinates for tiles
    NSArray *xNumbers = @[@20,@145,@270,@60,@145,@230,@105,@145,
    @185,@20,@60,@105,@185,@230,@270,@105,@145,
    @185,@60,@145,@230,@20,@145,@270];
    NSArray *yNumbers = @[@10, @10, @10, @80, @80, @80, @150, @150,
    @150, @220, @220, @220, @220, @220, @220, @290,
    @290, @290, @360, @360, @360, @430, @430, @430];
    
    float height = 30;
    float width = 30;
    for (int x = 0; x < [xNumbers count]; x++) {
        
        UIImageView *blockImageView = [[UIImageView alloc] initWithFrame:CGRectMake([xNumbers[x]intValue], [yNumbers[x]intValue], height, width)];
        //Tap Gesture recognizer will not function without userInteractionEnabled
        blockImageView.userInteractionEnabled = YES;
        
        //Identify tiles with a tag
        blockImageView.tag = x;
        [blockImageView setImage:woodenBlock];
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        //[tapRecognizer setDelegate:self];
        tapRecognizer.delegate = self;
        [blockImageView addGestureRecognizer:tapRecognizer];
        [self.view addSubview:blockImageView];
        
        [_tiles addObject:blockImageView];
    }
    //reset the counter for the owner of blocks.
    _numberOfPiecesOnBoard = 0;
}

-(void)pregameSetup:(UITapGestureRecognizer *)tapRecognizer{
    //add pieces to board logic

    //if the tile is already white/black do nothing so the user cannot overwrite previously set tiles, otherwise set the tile to the appropriate color
    if([tapRecognizer.view.backgroundColor isEqual:[UIColor whiteColor]] || [tapRecognizer.view.backgroundColor isEqual:[UIColor blackColor]]) {
        }
    else{
        [(UIImageView *)tapRecognizer.view setImage:nil];
        [(UIImageView *)tapRecognizer.view setBackgroundColor:_tileColor];
        //create a whilte tiles array to keep track of tag #'s of all white tiles currently on the board.
        NSNumber *whiteTile = [[NSNumber alloc] initWithInt:tapRecognizer.view.tag];
        [_whiteTiles addObject:whiteTile];
        NSNumber *viewTagInt = [[NSNumber alloc]initWithInt:tapRecognizer.view.tag];
        [_activePiecesLocationOnBoard addObject:viewTagInt];
        _numberOfPiecesOnBoard ++;
    }
    if(_numberOfPiecesOnBoard >= 8){
        _gameStarted = YES;
    }
}

-(void)tapRecognizer:(UITapGestureRecognizer *)tapRecognizer{
    //NSLog(@"%i",tapRecognizer.view.tag);

    if(_gameStarted == YES){
        
        //if there are blinking tiles and user picks a blinking tile change that to the current player's turn otherwise do the old whitePlayerTurnLogic//
        //if (tapRecognizer.view.tag)
        
        //no if statement for white vs black turn
        
        if(_whitesTurn == YES){
            [self whitePlayerTurn:tapRecognizer.view];
        }
        else{
            [self blackPlayerTurn:tapRecognizer.view];
        }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
