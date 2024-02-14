//
//  ChessGame.swift
//  Chess
//
//  Created by Eugeny on 20.07.2021.
//

import Foundation


class Chess<PieceVisual> : ObservableObject{
    public var emptySquareImage : PieceVisual
    public var chessPause = true
    public var pieces: [[Piece?]]
    public var whiteMoves = true
    public var visuals : [[PieceVisual]] = []
    public var prevMove = ((0,0),(0,0))
    public var moveHistory = [((0,0),(0,0))]
    public var promotePiece = Rank.queen
    public var history: [[[Piece?]]] = []
    public var mated = false
    public var checked = false
    @Published var timer = (600,600)
    var gameTimer: Timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in}
    public var move = 0
    init(emptySquare: PieceVisual,pieceContentFactory: (Rank, Player) -> PieceVisual) {
        emptySquareImage = emptySquare
        pieces = Array(repeating: Array(repeating: nil, count: 8), count: 8)
        for p in Player.allCases{
            visuals.append( [] )
            for r in Rank.allCases {
                visuals[p.rawValue].append( pieceContentFactory(r, p))//uploading visuals
            }
        }
        
        for i in 0..<2 {
            pieces[0+7*i][0] = Piece(rank: .rook, player: .white)
            pieces[0+7*i][7] = Piece(rank: .rook, player: .black)
            
            pieces[1 + 5 * i][0] = Piece(rank: .knight, player: .white)
            pieces[1 + 5 * i][7] = Piece(rank: .knight, player: .black)
            
            pieces[2 + 3 * i][0] = Piece(rank: .bishop, player: .white)
            pieces[2 + 3 * i][7] = Piece(rank: .bishop, player: .black)
            
       }
        
        for i in 0..<8 {
            pieces[i][1] = Piece(rank: .pawn, player: .white)
            pieces[i][6] = Piece(rank: .pawn, player: .black)
        }
        
        pieces[3][0] = Piece(rank: .queen, player: .white)
        pieces[3][7] = Piece(rank: .queen, player: .black)

        pieces[4][0] = Piece(rank: .king, player: .white)
        pieces[4][7] = Piece(rank: .king, player: .black)
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            if((self.prevMove.0 != (0,0) || self.prevMove.1 != (0,0)) &&  !self.chessPause){
                if(self.whiteMoves){self.timer.0 -= 1}
                else{self.timer.1 -= 1}
            }
        }
        history.append(pieces)
    }
    
    func pieceAt(col: Int,row: Int) -> Piece? {
        return pieces[col][row]
    }
    
    enum Player :Int,CaseIterable{
        case white=0
        case black=1
        
        var isWhite: Bool {
            self == .white
        }
    }
    
    enum Rank :Int,CaseIterable{
        case king=0
        case queen=1
        case bishop=2
        case rook=3
        case knight=4
        case pawn=5
    }
    
    struct Piece {
        var rank: Rank = .pawn
        var player: Player
        var moved = false
    }
    func visual(_ piece: Piece?) -> PieceVisual {
        if(piece != nil){
            return visuals[piece!.player.rawValue][piece!.rank.rawValue]
        }
        else{ return emptySquareImage}
    }
    func possibleMove(from: (Int,Int), to: (Int,Int)) -> Bool{
        if let a = pieceAt(col: from.0, row: from.1){
            if(a.player.isWhite != whiteMoves){
                return false
            }
            if((pieces[to.0][to.1] != nil)&&(a.player == pieces[to.0][to.1]?.player)){
                return false
            }
            switch a.rank {
            case .king:
                if((abs(from.0-to.0)>1)||(abs(from.1-to.1)>1)){
                    return false
                }
            case .knight:
                let shift=(abs(to.0-from.0),abs(to.1-from.1))
                return (shift == (1,2)) || (shift == (2,1))
            
            case .queen:
                if(abs(from.0-to.0) == abs(from.1-to.1)){
                    let direction = (to.0 - from.0 > 0 ?1:-1,to.1 - from.1 > 0 ?1:-1)
                    var scaner = (from.0+direction.0,from.1+direction.1)
                    while(scaner != (to.0,to.1)){
                        if(pieces[scaner.0][scaner.1] != nil){
                            return false
                        }
                        scaner.0 += direction.0
                        scaner.1 += direction.1
                    }
                    return true
                }
                if(from.0==to.0){
                    let direction = to.1 - from.1 > 0 ?1:-1
                    var scaner = from.1 + direction
                    while(scaner != to.1){
                        if(pieces[from.0][scaner] != nil){
                            return false
                        }
                        scaner += direction
                    }
                    return true
                }
                if(from.1==to.1){
                    let direction = to.0 - from.0 > 0 ?1:-1
                    var scaner = from.0 + direction
                    while(scaner != to.0){
                        if(pieces[scaner][from.1] != nil){
                            return false
                        }
                        scaner += direction
                    }
                    return true
                }
                return false
            case .bishop:
                if(abs(from.0-to.0) == abs(from.1-to.1)){
                    let direction = (to.0 - from.0 > 0 ?1:-1,to.1 - from.1 > 0 ?1:-1)
                    var scaner = (from.0+direction.0,from.1+direction.1)
                    while(scaner != (to.0,to.1)){
                        if(pieces[scaner.0][scaner.1] != nil){
                            return false
                        }
                        scaner.0 += direction.0
                        scaner.1 += direction.1
                    }
                    return true
                }
                return false
            case .rook:
                if(from.0==to.0){
                    let direction = to.1 - from.1 > 0 ?1:-1
                    var scaner = from.1 + direction
                    while(scaner != to.1){
                        if(pieces[from.0][scaner] != nil){
                            return false
                        }
                        scaner += direction
                    }
                    return true
                }
                if(from.1==to.1){
                    let direction = to.0 - from.0 > 0 ?1:-1
                    var scaner = from.0 + direction
                    while(scaner != to.0){
                        if(pieces[scaner][from.1] != nil){
                            return false
                        }
                        scaner += direction
                    }
                    return true
                }
                return false
            case .pawn:
                switch a.player {
                case .white:
                    let shift=(to.0-from.0,to.1-from.1)
                    if (shift == (0,2)){
                        return (from.1 <= 1) && (pieces[to.0][from.1+1] == nil) && (pieces[to.0][to.1] == nil)
                    }
                    if (shift == (0,1)){
                        return (pieces[to.0][to.1] == nil)
                    }
                    if (shift == (-1,1))||(shift == (1,1)){
                        return (pieces[to.0][to.1] != nil)
                    }
                case .black:
                    let shift=(to.0-from.0,to.1-from.1)
                    if (shift == (0,-2)){
                        return (from.1 >= 6) && (pieces[to.0][from.1-1] == nil) && (pieces[to.0][to.1] == nil)
                    }
                    if (shift == (0,-1)){
                        return (pieces[to.0][to.1] == nil)
                    }
                    if (shift == (-1,-1))||(shift == (1,-1)){
                        return (pieces[to.0][to.1] != nil)
                    }
                }
                return false
            }
            return true
        }
        return false
    }
    func change_Promotion(to: Rank){
        promotePiece = to
    }
    func promote(_ p:(Int,Int)){
        if((p.1==7)&&(pieces[p.0][p.1]?.rank == .pawn)&&(pieces[p.0][p.1]?.player == .white)){
            pieces[p.0][p.1]?.rank = promotePiece
        }
        if((p.1==0)&&(pieces[p.0][p.1]?.rank == .pawn)&&(pieces[p.0][p.1]?.player == .black)){
            pieces[p.0][p.1]?.rank = promotePiece
        }
    }
    func possiblePosition() -> Bool {
        let nonChecked = (whiteMoves ? Player.black : Player.white)
        var kingPos : (Int,Int)? = nil
        for col in 0..<pieces.count{
            for line in 0..<pieces[col].count {
                if((pieces[col][line]?.player==nonChecked)&&(pieces[col][line]?.rank == .king)){
                    kingPos = (col,line)
                }
            }
        }
        if (kingPos != nil){
            return !isChecked(pos: kingPos!)
        }
        return false
    }
    func isChecked(pos: (Int,Int),player: (Player?)=nil) -> Bool {
        var ghost = false
        var changedMove = false
        if (player != nil){
            if(pieces[pos.0][pos.1] == nil){
                pieces[pos.0][pos.1] = Piece(player: player!)
                ghost = true
            }
            if(whiteMoves != (player == .black)){
                changedMove = true
                whiteMoves = !whiteMoves
            }
        }
        for col in 0..<pieces.count{
            for line in 0..<pieces[col].count {
                if pieces[col][line]?.player == player{
                    continue
                }
                if(possibleMove(from: (col,line), to: pos)){
                    if ghost { pieces[pos.0][pos.1] = nil}
                    if changedMove { whiteMoves = !whiteMoves}
                    return true
                }
            }
        }
        if ghost { pieces[pos.0][pos.1] = nil}
        if changedMove { whiteMoves = !whiteMoves}
        return false
    }
    func phantomMove(from: (Int,Int), to: (Int,Int)){
        if(from.0 < 0 || from.1 < 0 || to.0 < 0 || to.1 < 0 || from.0 > 7 || from.1 > 7 || to.0 > 7 || to.1 > 7 ){return}
        if(possibleMove(from: from, to: to)){
            let position = self.pieces
            pieces[to.0][to.1] = pieces[from.0][from.1]
            pieces[to.0][to.1]?.moved = true
            pieces[from.0][from.1] = nil
            promote((to.0,to.1))
            whiteMoves = !whiteMoves
            if(!possiblePosition()){
                whiteMoves = !whiteMoves
                self.pieces=position
            }
            else {
                move += 1
            }
        }
        else {specialMove(from: from, to: to)}
    }
    //MARK move
    func move(from: (Int,Int), to: (Int,Int)){
        let now = move
        phantomMove(from: from, to: to)
        if(move > now){
            if(move >= history.count){
                history.append(pieces)
                moveHistory.append((from,to))
            }
            else {
                history[move] = pieces
                history = Array(history[0...move])
                moveHistory[move] = (from,to)
                moveHistory = Array(moveHistory[0...move])
            }
            prevMove = (from,to)
            mated = checkmate()
            if(!mated){chessPause = false}
            objectWillChange.send()
        }
    }
    
    func specialMove(from: (Int,Int), to: (Int,Int)){
        if(pieces[from.0][from.1]?.player.isWhite != whiteMoves){return}
        let position : [[Piece?]]
        switch pieces[from.0][from.1]?.rank {
        case .king:
            if (pieces[from.0][from.1]!.moved){return}
            let dir = to.0 - from.0
            if (abs(dir) != 2){return}
            if (to.1-from.1 != 0){return}//imposible move
            let rookPos = dir==2 ? 7 : 0
            if (pieces[rookPos][from.1]?.rank != Rank.rook){return}//not rook
            if (pieces[rookPos][from.1]!.moved){return}//rook moved
            var scanner = from.0
            while (scanner != to.0){
                if (isChecked(pos: (scanner,from.1),player: (from.1==0 ? .white:.black))){return}//checked or beaten field
                scanner += dir/2
                if(pieces[scanner][from.1] != nil){return} // pieces in the way
            }
            if ((rookPos == 0)&&(pieces[1][from.1] != nil)){return}//b-line is empty in long castle
            //Move now
            position = pieces
            pieces[to.0][to.1] = pieces[from.0][from.1]
            pieces[from.0 + dir/2][from.1] = pieces[rookPos][from.1]
            pieces[from.0][from.1] = nil
            pieces[rookPos][from.1] = nil
        case .pawn:
            switch pieces[from.0][from.1]!.player {
            case .white:
                if (abs(to.0-from.0) != 1 && to.1-from.1 != 1){return}//bad move
                if (from.1 != 4){return}//bad position
                if (prevMove.0 != (to.0 , 6) && prevMove.1 != (to.0 , 4)){return}//bad prev move
                if (pieces[prevMove.1.0][prevMove.1.1]?.rank != .pawn){return} //not a pawn
                if(pieces[to.0][to.1] != nil){return}//empty space
                //Move now
                position = pieces
                pieces[to.0][to.1] = pieces[from.0][from.1]
                pieces[to.0][to.1-1] = nil
                pieces[from.0][from.1] = nil
            case .black:
                if (abs(to.0-from.0) != 1 && to.1-from.1 != -1){return}//bad move
                if (from.1 != 3){return}//bad position
                if (prevMove.0 != (to.0 , 1) && prevMove.1 != (to.0 , 3)){return}//bad prev move
                if (pieces[prevMove.1.0][prevMove.1.1]?.rank != .pawn){return} //not a pawn
                if(pieces[to.0][to.1] != nil){return}//empty space
                //Move now
                position = pieces
                pieces[to.0][to.1] = pieces[from.0][from.1]
                pieces[to.0][to.1+1] = nil
                pieces[from.0][from.1] = nil
            }
        default:
            return
        }
        whiteMoves = !whiteMoves
        if(!possiblePosition()){
            whiteMoves = !whiteMoves
            self.pieces=position
        }
        else {
            move += 1
        }
    }
    func redact(to: (Int,Int),put: Piece?){
        chessPause = true
        pieces[to.0][to.1] = put
        objectWillChange.send()
    }
    func visual(_ x: Int,_ y: Int) -> PieceVisual {
        if(x>=visuals.count || x<0){return emptySquareImage}
        if(y>=visuals[x].count || y<0){return emptySquareImage}
        return visuals[x][y]
    }
    func timerAdd(white tw: Int? = nil ,black tb: Int? = nil){
        chessPause = true
        timer.0 += tw ?? 0
        timer.1 += tb ?? 0
        objectWillChange.send()
    }
    func timerSet(white tw: Int? = nil,black tb: Int? = nil){
        chessPause = true
        if(tw != nil){timer.0 = tw!}
        if(tb != nil){timer.1 = tb!}
        objectWillChange.send()
    }
    func toMove(to: Int){
        if((history.count > to) && (to > -1)){
            pieces = history[to]
            prevMove = moveHistory[to]
            whiteMoves = whiteMoves != ((move - to) % 2 != 0)
            move = to
            chessPause = true
            objectWillChange.send()
        }
    }
    func checkmate() -> Bool {
        let now = move
        var kingPos = (0,0)
        //TODO: Make faster
        for i in (0...7){
            for j in (0...7){
                if (pieces[i][j]?.player.isWhite == whiteMoves){
                    if (pieces[i][j]?.rank == .king){kingPos = (i,j)}
                    for i1 in (0...7){
                        for j1 in (0...7){
                            phantomMove(from: (i, j), to: (i1, j1))
                            if(move > now){
                                toMove(to: now)
                                return false
                            }
                        }
                    }
                }
            }
        }
        chessPause = true
        checked = isChecked(pos: kingPos, player: whiteMoves ? .white : .black)
        return true
    }
}

extension Chess: CustomStringConvertible {
    var description: String {
        var desc = ""
        for i in 0..<8 {
            desc += "\(7 - i)"
            for col in 0..<8 {
                if let piece = pieceAt(col: col, row: 7 - i) {
                    desc += " "
                    switch piece.rank {
                    case .king:
                        desc += piece.player == .white ? "k" : "K"
                    case .queen:
                        desc += piece.player == .white ? "q" : "Q"
                    case .bishop:
                        desc += piece.player == .white ? "b" : "B"
                    case .rook:
                        desc += piece.player == .white ? "r" : "R"
                    case .knight:
                        desc += piece.player == .white ? "n" : "N"
                    case .pawn:
                        desc += piece.player == .white ? "p" : "P"
                    }
                } else {
                    desc += " ."
                }
            }
            desc += "\n"
        }
        desc += "  0 1 2 3 4 5 6 7"
        
        return desc
    }
}
