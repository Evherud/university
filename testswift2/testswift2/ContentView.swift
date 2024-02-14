//
//  ContentView.swift
//  testswift2
//
//  Created by Eugeny on 20.07.2021.
//

import SwiftUI
import Combine

func fileIsImage(_ file: String) -> Bool{
    let Images=["png","jpg","jpeg","gif"]
    for ext in Images{
        if file.hasSuffix(ext){
            return true
        }
    }
    return false
}

struct ContentView: View {
    @State var selected=10
    @State var textInSelected=""
    var body: some View {
        
        VStack{
            HStack{
                TextField("type tab number", text: $textInSelected)
                    .frame(width: 130.0)
                Button("go to tab"){
                    if let converted=Int(textInSelected){
                        selected=converted-1
                    }
                }
            }
            ScrollView {
                //MARK:MAIN VIEW
                TabView(selection: $selected){
                    Tab1()
                        .tabItem {
                            Label("1", systemImage: "bolt.fill")
                        }.tag(0)
                    Tab2()
                        .tabItem {
                            Label("2", systemImage: "square.and.pencil")
                        }.tag(1)
                    Tab3()
                        .tabItem {
                            Label("3", systemImage: "3.square.fill")
                        }.tag(2)
                    Tab4()
                        .tabItem {
                            Label("4", systemImage: "3.square.fill")
                        }.tag(3)
                    Tab5(selected: $selected)
                        .tabItem {
                            Label("5", systemImage: "3.square.fill")
                        }.tag(4)
                    Tab6()
                        .tabItem {
                            Label("6", systemImage: "3.square.fill")
                        }.tag(5)
                    Tab7()
                        .tabItem {
                            Label("7", systemImage: "3.square.fill")
                        }.tag(6)
                    Tab8()
                        .tabItem {
                            Label("8", systemImage: "3.square.fill")
                        }.tag(7)
                    Temp()
                        .tabItem {
                            Label("9", systemImage: "3.square.fill")
                        }.tag(8)
                    Tab10()
                        .tabItem {
                            Label("10", systemImage: "3.square.fill")
                        }.tag(10)
                }
            }
        }
    }
}


struct Tab1: View {
    @State var z=100
    @State var i=52
    @State var slider=0.6
    @State var red=0.5
    @State var green=0.5
    @State var blue=0.5
    @State var ed=false
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: red,green: green,blue: blue),style:FillStyle(
                    eoFill: true,
                    antialiased: false
                )
                )
            VStack{
                HStack {
                    Text("Hello, world!")
                        .padding()
                    Button("i++"){
                        Pes(&i)
                        print(i);
                    }
                    .padding(.all, 20.0)
                    .background(Color.green)
                    Button(action: {
                        Pes(&i)
                        print("Pes");
                        print(i);
                    }, label: {
                        VStack {
                            Text("can't add Vstack")
                            Text("random color ->")
                            Text("to a button")
                        }
                        Button(action: {
                            red=Double(Int.random(in: 0...100))/100
                            green=Double(Int.random(in: 0...100))/100
                            blue=Double(Int.random(in: 0...100))/100
                        }, label: {
                            Text("Button in a button")
                        })
                        Text("original button")
                        
                    }).padding(.vertical, 20.0)
                    .background(Color.white).onDrag{
                        let pes=NSItemProvider(object: "Stolen Pes" as NSString)
                        //pes=NSItemProvider(contentsOf: URL(string: "1.png"))!
                        //MARK OnDrag
                        print(pes)
                        return pes
                    }
                    .opacity(0.9)
                    
                    
                }
                .frame(height: 200.0)
                Slider(value: $slider,
                       in: -100...100)
                Slider(value: $red){ Text("r="+String(format:"%.2f",red))}
                Slider(value: $green){ Text("g="+String(format:"%.2f",green))}
                Slider(value: $blue){ Text("b="+String(format:"%.2f",blue))}
                Slider(
                    value: $slider,
                    in: -Double(i)...Double(i),
                    onEditingChanged:
                        {(editing) ->Void in
                            ed=editing
                        }
                    ,
                    minimumValueLabel: Text(String(-i))
                    ,
                    maximumValueLabel: Text(String(i))
                ){}
                
                Image("1")
                Text(String(i))
                Text(String(format:"%.3f",slider))
                Text(String(ed))
                
            }
        }
    }
}



struct Tab2: View {
    @State var selectedAnimal=1
    @State var newAnimals=0
    var body: some View {
        VStack{
            Picker(selection: $selectedAnimal, label: Text("Select an animal")) {
                Text("Dog").tag(1)
                Text("Cat").tag(2)
                Text("Racoon").tag(3)
                Text("XXX").tag(4)
            }
            GeometryReader { geo in
                Button(String(format:"X: %.2f Y: %.2f",
                              geo.frame(in: .global).midX,
                              geo.frame(in: .global).midY)){
                    selectedAnimal=4
                }
                .frame(width: 0.5*geo.size.width)
                .background(Color.green)
                .position(x: geo.frame(in: .local).midX)
            }.background(Color.red)
        }
        
    }
}

struct Tab3: View{
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            .rotation3DEffect(.degrees(Double(geo.frame(in:
                                                                            .global).minY - fullView.size.height / 2) / 5),
                                              axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }.frame(height: 500.0)
    }
}

struct animalDescription: Identifiable {
    let animal: String
    let description: String
    let id = UUID()
}


struct Tab4: View {
    @State var size=1
    @State var psize=1
    @State var esize=1
    @State var cap=1
    @State var sizeInStr="1000"
    @State var psizeInStr="1000"
    @State var esizeInStr="1000"
    @State var animal="Pes"
    @State var description="MhomPoros"
    @State var animalDescriptions=[
        animalDescription(animal: "Pes", description: "MhomPoros")
    ]
    @State var primes:[Int]=[]
    
    @State var minDiv:[Int]=[0,0]
    
    @State var euler:[Int]=[0,0]
    
    @State var animalDictionary = [
        "Pes":"MhomPoros"
    ]
    func generate(n:Int){
        var tprimes=primes
        var tminDiv=minDiv
        var teuler=euler
        tminDiv+=Array(repeating: 0, count: n-cap)
        teuler+=Array(repeating: 0, count: n-cap)
        var PtoPow:Int
        for i in 2...n{
            if(tminDiv[i]==0){
                tminDiv[i]=i;
                tprimes.append(i)
                teuler[i]=i-1
            }
            for p in tprimes{
                if((i*p>n)||(p>tminDiv[i])){break}
                tminDiv[i*p]=p
                PtoPow=p
                while(i%PtoPow==0){
                    PtoPow*=p
                }
                teuler[i*p]=teuler[i]/(PtoPow/p-PtoPow/p/p)*(PtoPow-PtoPow/p)
            }
        }
        cap=n
        euler=teuler
        primes=tprimes
        minDiv=tminDiv
    }
    var body: some View {
        GeometryReader{ geo in
            VStack{
                DisclosureGroup(
                    content: {
                        HStack{
                            TextField("animal", text: $animal)
                            TextField("descriprion", text: $description)
                            Button("add to list"){
                                animalDescriptions.append(animalDescription(
                                                            animal: animal,description: description))
                                animalDictionary[animal]=description
                                print(animalDictionary)
                            }
                        }
                        //            List(animalDescriptions){i in
                        //                HStack{
                        //                    Text(i.animal)
                        //                    Text(i.description)
                        //                }
                        //            }.frame( height: 100.0)
                        
                        List{
                            ForEach(animalDictionary.sorted(by: <),
                                    id: \.key) {key,value in
                                HStack{
                                    Text(key)
                                    Text(value)
                                }
                                
                            }
                        }.frame(width: geo.size.width*0.8, height:300)
                    }){
                    Image("2")
                }
                DisclosureGroup("Division things") {
                    let columns: [GridItem] =
                        Array(repeating: .init(.flexible()), count: 2)
                    // MARK: Min Divisors
                    HStack{
                        TextField("input number",text :$sizeInStr)
                        Button("generate"){
                            if let converted=Int(sizeInStr){
                                if (cap<converted){
                                    generate(n: converted)
                                }
                                size = converted
                            }
                            else{
                                sizeInStr=""
                            }
                        }
                    }
                    
//                    List{
//                        if(2<=size){
//                            //                    ForEach(2..<(size+1)){ i in
//                            //                        HStack{
//                            //                            Text(String(i))
//                            //                            Text(String(minDiv[i]))
//                            //                        }
//                            //                    }
//
//                            ForEach(minDiv.indices, id:\.self){i in
//                                if(i>=2 && i<=size){
//                                    HStack{
//                                        Text(String(i))
//                                        Text(String(minDiv[i]))
//                                    }
//                                }
//                            }
//                        }
//                    }.frame(width: geo.size.width*0.8, height:300)
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=size){
                                ForEach(minDiv.indices, id:\.self){i in
                                    if(i>=2 && i<=size){
                                            Text(String(i))
                                            Text(String(minDiv[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                    
                    // MARK: Primes
                    HStack{
                        TextField("input number",text :$psizeInStr)
                        Button("generate primes"){
                            if let converted=Int(psizeInStr){
                                if (cap<converted){
                                    generate(n: converted)
                                }
                                psize = converted
                            }
                            else{
                                psizeInStr=""
                            }
                        }
                    }
//                    List{
//                        if(2<=psize){
//                            //                    ForEach(2..<(psize)){ i in
//                            //                        if((i<primes.count)&&(primes[i]<=psize)){
//                            //                            HStack{
//                            //                                Text(String(i))
//                            //                                Text(String(primes[i]))
//                            //                            }
//                            //                        }
//                            //                    }
//                            ForEach(primes.indices, id:\.self){i in
//                                if( primes[i]<=psize){
//                                    HStack{
//                                        Text(String(i+1))
//                                        Text(String(primes[i]))
//                                    }
//                                }
//                            }
//                        }
//                    }.frame(width: geo.size.width*0.8, height:300)
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=psize){
                                ForEach(primes.indices, id:\.self){i in
                                    if( primes[i]<=psize){
                                            Text(String(i+1))
                                            Text(String(primes[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                    // MARK: Euler func
                    HStack{
                        TextField("input number",text :$esizeInStr)
                        Button("euler function"){
                            if let converted=Int(esizeInStr){
                                if (cap<converted){
                                    generate(n: converted)
                                }
                                esize = converted
                            }
                            else{
                                esizeInStr=""
                            }
                        }
                    }
                    
                    //                    List{
                    //                        if(2<=esize){
                    //                            //                    ForEach(1..<(esize+1)){ i in
                    //                            //                        HStack{
                    //                            //                            Text(String(i))
                    //                            //                            Text(String(euler[i]))
                    //                            //                        }
                    //                            //                    }
                    //                            ForEach(euler.indices, id:\.self){i in
                    //                                if(i>=1 && i<=esize){
                    //                                    HStack{
                    //                                        Text(String(i))
                    //                                        Text(String(euler[i]))
                    //                                    }
                    //                                }
                    //                            }
                    //                        }
                    //                    }.frame(width: geo.size.width*0.8, height:300)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=esize){
                                //                    ForEach(1..<(esize+1)){ i in
                                //                        HStack{
                                //                            Text(String(i))
                                //                            Text(String(euler[i]))
                                //                        }
                                //                    }
                                ForEach(euler.indices, id:\.self){i in
                                    if(i>=1 && i<=esize){
                                        Text(String(i))
                                        Text(String(euler[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                    
                }
            }
        }.frame(height:5000)
    }
}

struct Tab5: View{
    @Binding var selected : Int
    @State var Images : [String]=[]
    @State var color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State var textInSelected = "5"
    @State var path = ""
    var body: some View {
        GeometryReader { geo in
            VStack{
                ColorPicker( selection: $color){
                    Text("Color picker")
                        .foregroundColor(color)
                        .background(color.colorInvert())
                }.padding(.bottom,20)
                let rows = [
                    GridItem(.adaptive(minimum: 80, maximum: 100))
                ]
//MARK: Grid
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, alignment: .top) {
                        ForEach((0...79), id: \.self) {
                            let codepoint = $0 + 0x1f600
                            let codepointString = String(format: "%02X", codepoint)
                            Text("\(codepointString)")
                                .font(.footnote)
                            let emoji = String(Character(UnicodeScalar(codepoint)!))
                            Text("\(emoji)")
                                .font(.largeTitle)
                        }
                    }
                }.frame(height:300)
                
                let columns = [
                    GridItem(.adaptive(minimum: 80, maximum: 100))
                ]
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach((0...79), id: \.self) {
                            let codepoint = $0 + 0x1f600
                            let emoji = String(Character(UnicodeScalar(codepoint)!))
                            Text("\(emoji)")
                        }
                    }
                }.font(.largeTitle).frame(height: 300).padding(.bottom, 30.0)
//              MARK: Files
                Button("choose file"){
                    let fm = FileManager.default
                    let dialog = NSOpenPanel()
                    dialog.canChooseDirectories = true
                    dialog.begin{i in
                        path=dialog.url!.absoluteString
                        path.removeFirst(7)
                        Images = try! fm.subpathsOfDirectory(atPath: path)
                    }
                }

                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(Images, id:\.self){i in
                            if(fileIsImage(i)){
                                let k = path + i
                                if let im = NSImage(byReferencingFile: k){
                                    Image(nsImage: im).resizable().aspectRatio(contentMode: .fit)
                                }
//                                Text(k)
                            }
                        }
                    }
                }.frame(height: 200)
                
                DisclosureGroup("Group") {
                    HStack{
                        TextField("type tab number", text: $textInSelected)
                            .frame(width: 130.0)
                            .gesture(
                                DragGesture()
                                          .onChanged { value in
                                             print("pes")
                                          }
                                         .onEnded{value in
                                            print("sobaka")
                                         })
                        Button("go to tab"){
                            NSCursor.closedHand.set()
                            if let converted=Int(textInSelected){
                                selected=converted-1
                            }
                        }
                    }
                }
            }
        }.frame(height: 2500.0)
        
    }
}

class primeInfo: ObservableObject{
    var primes:[Int]=[]
    var minDiv:[Int]=[0,0]
    var euler:[Int]=[0,0]
    var size=1
    var psize=1
    var esize=1
    var cap=1
}
class Dictionary: ObservableObject {
    var dictionary = [
        "Pes":"MhomPoros"
    ]{didSet {objectWillChange.send()}}
}
struct Tab6: View {
    @ObservedObject var decomposition=primeInfo()
    @ObservedObject var animalDescription=Dictionary()
    @State var sizeInStr="1000"
    @State var psizeInStr="1000"
    @State var esizeInStr="1000"
    @State var animal="Pes"
    @State var description="MhomPoros"
    func generate(n:Int){
        decomposition.minDiv+=Array(repeating: 0, count: n-decomposition.cap)
        decomposition.euler+=Array(repeating: 0, count: n-decomposition.cap)
        for i in 2...n{
            if(decomposition.minDiv[i]==0){
                decomposition.minDiv[i]=i;
                decomposition.primes.append(i)
                decomposition.euler[i]=i-1
            }
            for p in decomposition.primes{
                if((i*p>n)||(p>decomposition.minDiv[i])){break}
                decomposition.minDiv[i*p]=p
                var PtoPow=p
                while(i%PtoPow==0){
                    PtoPow*=p
                }
                decomposition.euler[i*p]=decomposition.euler[i]/(PtoPow/p-PtoPow/p/p)*(PtoPow-PtoPow/p)
            }
        }
        decomposition.cap=n
    }
    var body: some View {
        GeometryReader{ geo in
            VStack{
                DisclosureGroup(
                    content: {
                        HStack{
                            TextField("animal", text: $animal)
                            TextField("descriprion", text: $description)
                            Button("add to list"){
                                animalDescription.dictionary[animal]=description
                            }
                        }
                        //            List(animalDescriptions){i in
                        //                HStack{
                        //                    Text(i.animal)
                        //                    Text(i.description)
                        //                }
                        //            }.frame( height: 100.0)
                        
                        List{
                            ForEach(animalDescription.dictionary.sorted(by: <),
                                    id: \.key) {key,value in
                                HStack{
                                    Text(key)
                                    Text(value)
                                }
                                
                            }
                        }.frame(width: geo.size.width*0.8, height:300)
                    }){
                    Image("2")
                }
                DisclosureGroup("Division things") {
                    let columns: [GridItem] =
                        Array(repeating: .init(.flexible()), count: 2)
                    // MARK: Min Divisors
                    HStack{
                        TextField("input number",text :$sizeInStr)
                        Button("generate"){
                            if let converted=Int(sizeInStr){
                                if (decomposition.cap<converted){
                                    generate(n: converted)
                                }
                                decomposition.size = converted
                                decomposition.objectWillChange.send()
                            }
                            else{
                                sizeInStr=""
                            }
                        }
                    }
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=decomposition.size){
                                ForEach(decomposition.minDiv.indices, id:\.self){i in
                                    if(i>=2 && i<=decomposition.size){
                                            Text(String(i))
                                        Text(String(decomposition.minDiv[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                    // MARK: Primes
                    HStack{
                        TextField("input number",text :$psizeInStr)
                        Button("generate primes"){
                            if let converted=Int(psizeInStr){
                                if (decomposition.cap<converted){
                                    generate(n: converted)
                                }
                                decomposition.psize = converted
                                decomposition.objectWillChange.send()
                            }
                            else{
                                psizeInStr=""
                            }
                        }
                    }
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=decomposition.psize){
                                ForEach(decomposition.primes.indices, id:\.self){i in
                                    if( decomposition.primes[i]<=decomposition.psize){
                                            Text(String(i+1))
                                        Text(String(decomposition.primes[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                    // MARK: Euler func
                    HStack{
                        TextField("input number",text :$esizeInStr)
                        Button("euler function"){
                            if let converted=Int(esizeInStr){
                                if (decomposition.cap<converted){
                                    generate(n: converted)
                                }
                                decomposition.esize = converted
                                decomposition.objectWillChange.send()
                            }
                            else{
                                esizeInStr=""
                            }
                        }
                    }
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            if(2<=decomposition.esize){
                                ForEach(decomposition.euler.indices, id:\.self){i in
                                    if(i>=1 && i<=decomposition.esize){
                                        Text(String(i))
                                        Text(String(decomposition.euler[i]))
                                    }
                                }
                            }
                        }.font(.largeTitle)
                    }.frame(width: geo.size.width*0.8, height:300)
                }
            }
        }.frame(height:5000)
    }
}



struct Tab7: View {
    @ObservedObject var chessboard = Chess<String>(emptySquare: "  ") {
        (rank, player) in
        switch rank {
        case .king:
            return player.isWhite ? " ♔" : " ♚"
        case .queen:
            return player.isWhite ? " ♕" : " ♛"
        case .bishop:
            return player.isWhite ? " ♗" : " ♝"
        case .rook:
            return player.isWhite ? " ♖" : " ♜"
        case .knight:
            return player.isWhite ? " ♘" : " ♞"
        case .pawn:
            return player.isWhite ? " ♙" : " ♟"
        }
    }
    

    @ObservedObject var bigChessboard = Chess<Image>(emptySquare: Image("empty")){
        (rank, player) in
        switch rank {
        case .king:
            return player.isWhite ?  Image("King-white") : Image("King-black")
        case .queen:
            return player.isWhite ?  Image("Queen-white") : Image("Queen-black")
        case .bishop:
            return player.isWhite ?  Image("Bishop-white") : Image("Bishop-black")
        case .rook:
            return player.isWhite ?  Image("Rook-white") : Image("Rook-black")
        case .knight:
            return player.isWhite ?  Image("Knight-white") : Image("Knight-black")
        case .pawn:
            return player.isWhite ?  Image("Pawn-white") : Image("Pawn-black")
        }
    }
    @State var selected : (Int,Int)?
    @State var selected1 : (Int,Int)?
    @State var animating = false
    @State var editState = 0
    @State var editPiece = 1
    @State var whiteTimer = 600
    @State var blackTimer = 600
    @State var whiteTimeRedact = "600"
    @State var blackTimeRedact = "600"
    @State var selectedFigureDelta = (CGFloat(0) , CGFloat(0))
    @State var animationDelta = (CGFloat(0) , CGFloat(0))
    @State var animationProgress = CGFloat(0)
    var body: some View {
//        VStack{
//            Text((bigChessboard.checked ? "Check" : "Stale")+"mate")
//                .font(.largeTitle)
//                .foregroundColor(Color(red: 1, green: 0.1, blue: 0.3, opacity: bigChessboard.mated ? 1 : 0))
//            HStack{
//                ZStack{
//                    VStack(spacing: 0){
//                        ForEach (0..<8) { row in
//                            HStack(spacing: 0){
//                                ForEach (0..<8) { col in
//                                    ZStack{
//                                        bigChessboard.visual(bigChessboard.pieceAt(col: col, row: 7-row))
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 80, height: 80)
//                                            .gesture(
//                                                LongPressGesture(minimumDuration: 0, maximumDistance: 0)
//                                                    .onEnded{ _ in
//                                                    switch(editState){
//                                                    case 1,2:
//                                                        NSSound(named: "Pop")?.play()
//                                                        if let r = Chess<Image>.Rank(rawValue: editPiece){
//                                                            bigChessboard.redact(to: (col,7-row), put: Chess.Piece(rank: r, player: Chess.Player(rawValue: editState-1)!))
//                                                        }
//                                                        else {bigChessboard.redact(to: (col,7-row), put: nil)}
//                                                    default:
//                                                        if(selected1 == nil){
//                                                            NSSound(named: "Ping")?.play()
//                                                            if (bigChessboard.pieceAt(col: col, row: 7-row) != nil){
//                                                                selected1 = (col,7-row)
//                                                            }
//                                                            print(selected1 ?? "cat")
//                                                        }
//                                                        else{
//                                                            let nowMove = bigChessboard.move
//                                                            bigChessboard.move(from: (selected1!.0,selected1!.1),
//                                                                            to: (col,7-row))
//                                                            if(nowMove < bigChessboard.move){
//                                                                NSSound(named: "Morse")?.play()
//                                                                animating = true
//                                                                withAnimation(.easeInOut(duration: 1)){
////                                                                    animationDelta = (CGFloat(col - selected1!.0)*100,CGFloat(selected1!.1 + row - 7)*100)
////                                                                    animating = false
//                                                                    animationProgress = 1
//                                                                }
//                                                                animationDelta = (0,0)
//                                                                bigChessboard.objectWillChange.send()
//                                                            }
//                                                            else{
//                                                                NSSound(named: "Hero")?.play()
//                                                            }
//                                                            selected1 = nil
//                                                        }
//                                                    }
//
//                                                }
//                                            )
//                                    }.frame(width: 100, height: 100)
//                                     .background(Color(red: 0.7 - Double((col+row) % 2) * 0.3, green: 0.7 - Double((col+row) % 2) * 0.3,
//                                                       blue: 0.7 - Double((col+row) % 2) * 0.3 + ((selected1?.0 == col) && (selected1?.1 == 7-row) ? 0.3 : 0.0)  ))
//    //                                .animation(.spring(dampingFraction: 0.5)
//    //                                                   .speed(0.2)
//    //                                                   .delay(0.03))
//                                }
//                            }
//                        }
//                    }
//                    GeometryReader { geo in
//                        ZStack{
//                            if let (col,row) = selected1 {
//                                //MARK: Selected square
//                                Color(red: 0.4 + ((col + row)%2 == 0 ? 0 : 0.3), green: 0.4 + ((col + row)%2 == 0 ? 0 : 0.3), blue: 0.7 + ((col + row)%2 == 0 ? 0 : 0.3))
//                                .frame(width: 100, height: 100)
//                                .position(x: geo.frame(in: .local).midX - 481 + 100.0 * CGFloat(col) + 131, y:geo.frame(in: .local).minY + 100 * (7-CGFloat(row)) + 62)
//                                //MARK: Draggable piece
//                                bigChessboard.visual(bigChessboard.pieceAt(col: col, row: row))
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .position(x: selectedFigureDelta.0 + geo.frame(in: .local).midX - 481 + 100.0 * CGFloat(col) + 131, y: geo.frame(in: .local).minY + selectedFigureDelta.1 + 100 * (7-CGFloat(row)) + 62)
//                                .gesture(
//                                     DragGesture()
//                                         .onChanged { value in
//                                            selectedFigureDelta.0 = value.location.x - (geo.frame(in: .local).midX - 481 + 100.0 * CGFloat(col) + 131)
//                                            selectedFigureDelta.1 = value.location.y - (100 * (7-CGFloat(row)) + geo.frame(in: .local).minY + 62)
//                                         }
//                                        .onEnded{value in
//                                            let colto = Int(value.location.x - (geo.frame(in: .local).midX - 481 + 131) + 50)/100
//                                            let rowto = Int(-value.location.y + 812 - geo.frame(in: .local).minY)/100
//                                            bigChessboard.move(from: (col, row), to: (colto, rowto))
//                                            selectedFigureDelta = (0,0)
//                                            print(colto,rowto)
//                                            selected1 = nil
//                                        }
//                                )
//                            }
//                            //MARK: Animating piece
//                            let (col,row) : (Int,Int) = (bigChessboard.prevMove.0.0,bigChessboard.prevMove.0.1)
//                            let (col1,row1) = (bigChessboard.prevMove.1.0,bigChessboard.prevMove.1.1)
//                            Color(white: (col1 + row1)%2 == 0 ? 0.4 : 0.7)
//                                .frame(width: 100, height: 100)
//                                .position(x: geo.frame(in: .local).midX - 481 + 100.0 * CGFloat(col1) + 131, y: 100 * (7-CGFloat(row1)) + geo.frame(in: .local).minY + 62)
//                                .opacity(animating ? 1 : 0)
//                            bigChessboard.visual(bigChessboard.pieceAt(col: col1, row: row1))
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .position(x: geo.frame(in: .local).midX - 481 + 100.0 * CGFloat(col) + 131, y: 100 * (7-CGFloat(row)) + geo.frame(in: .local).minY + 62)
//                                .opacity(animating ? 1 : 0)
//                                .modifier(
//                                    MoveXYEnd(
//                                        totalDistanceX: 100 * CGFloat(col1 - col),
//                                        totalDistanceY: 100 * CGFloat(row - row1),
//                                        percentage: animationProgress
//                                  ) {
//                                        animating = false
//                                        animationProgress = 0
//                                        print(geo.frame(in: .local).midX,geo.frame(in: .local).minX)
//                                  }
//                                )
//                        }
//                    }
//
//                }
//                //MARK: Timer
//                VStack{
//                    HStack{
//                        TextField("seconds", text: $blackTimeRedact)
//                        VStack{
//                            Button("Set"){
//                                bigChessboard.timerSet(black: Int(blackTimeRedact))
//                            }
//                            Button("Add"){
//                                bigChessboard.timerAdd(black: Int(blackTimeRedact))
//                            }
//                        }
//                    }.frame(width: 100.0, height: 40.0)
//                    Text(String(bigChessboard.timer.1/60) + " : " + String(bigChessboard.timer.1%60))
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .frame(width: 100.0, height: 80.0)
//                    Text((bigChessboard.whiteMoves ? "White" : "Black") + " moves").frame(width: 100, height: 100)
//                        .background(Color(white: bigChessboard.whiteMoves ? 0 : 1))
//                        .foregroundColor(Color(white: bigChessboard.whiteMoves ? 1 : 0))
//                        .onTapGesture {
//                            bigChessboard.whiteMoves = !bigChessboard.whiteMoves
//                            bigChessboard.objectWillChange.send()
//                        }
//                    Text("Promotion:")
//                    ForEach(1..<5){i in
//                        bigChessboard.visuals[0][i].resizable().frame(width: 100, height: 100).onTapGesture {
//                            bigChessboard.change_Promotion(to: Chess.Rank(rawValue: i)!)
//                            bigChessboard.objectWillChange.send()
//                        }.background(Color(red: 0.5, green: 0.5, blue: 1, opacity: bigChessboard.promotePiece.rawValue == i ? 1 : 0))
//                    }
//                    Text(String(bigChessboard.timer.0/60) + " : " + String(bigChessboard.timer.0%60))
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .frame(width: 100.0, height: 80.0)
//                    HStack{
//                        TextField("seconds", text: $whiteTimeRedact)
//                        VStack{
//                            Button("Set"){
//                                bigChessboard.timerSet(white: Int(whiteTimeRedact))
//                            }
//                            Button("Add"){
//                                bigChessboard.timerAdd(white: Int(whiteTimeRedact))
//                            }
//                        }
//                    }.frame(width: 100.0, height: 40.0)
//                }
//                VStack{
//                    Button("undo"){
//                        bigChessboard.toMove(to: bigChessboard.move - 1)
//                    }
//                    Button("redo"){
//                        bigChessboard.toMove(to: bigChessboard.move + 1)
//                    }
//                }
//            }
//            //MARK: Redactor
//            HStack{
//                Text("Edit:")
//                ForEach(-1..<6){i in
//                    bigChessboard.visual(editState-1, i).resizable().frame(width: 100, height: 100).onTapGesture {
//                        editPiece = i
//                    }.background(Color(red: 0.5, green: 1, blue: 0.5, opacity: editPiece == i ? 1 : 0))
//                }
//                Picker(selection: $editState, label: Text("Color")) {
//                    Text("Play").tag(0)
//                    Text("White").tag(1)
//                    Text("Black").tag(2)
//                }
//            }
//            VStack {
//                ForEach (0..<8) {i in
//                    HStack {
//                        ForEach (0..<8) {j in
//                            Button(action:{
//                                if(selected == nil){
//                                    if (chessboard.pieceAt(col: j, row: 7-i) != nil){
//                                        selected = (j,7-i)
//                                    }
//                                    print(selected ?? "pes")
//                                }
//                                else{
//                                    chessboard.move(from: (selected!.0,selected!.1),
//                                                    to: (j,7-i))
//                                    print((j,7-i))
//                                    selected = nil
//                                    chessboard.objectWillChange.send()
//                                }
//                            }){
//                                ZStack {
//                                    if let piece = (chessboard.pieceAt(col: j,row: 7-i)){
//                                        if((selected != nil)&&(selected! == (j,7-i))){
//                                            Text(chessboard.visual(piece)).font(.title).foregroundColor(Color.blue)
//                                        }
//                                        else {
//                                            Text(chessboard.visual(piece)).font(.title)
//                                        }
//                                    }
//                                }.frame(width: 20, height: 20, alignment: .bottom)
//                            }
//                        }
//                    }
//                }
                HStack{
                    ForEach(1..<5){i in
                        Button(action: {
                            chessboard.change_Promotion(to: Chess.Rank(rawValue: i)!)
                        }){
                            Text(chessboard.visuals[0][i])
                        }
                    }
                }
        
//            }
//        }
        
    }

}

struct Tab10: View{
    var body: some View {
        //Rectangle 1
        // Composition groups need to live inside some a stack. (VStack, ZStack, or HStack)
//Text("pes")
        ZStack {
            Rectangle()
            .fill(Color(#colorLiteral(red: 0.364705890417099, green: 0.37254902720451355, blue: 0.9372549057006836, alpha: 1)))

            Rectangle()
            .strokeBorder(Color(#colorLiteral(red: 0.9833333492279053, green: 0.5916389226913452, blue: 0.0040972232818603516, alpha: 1)), style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [23,3]))
            //Rectangle 2
            Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .frame(width: 237, height: 309)
            .rotationEffect(.degrees(32.12))
        }
        .compositingGroup()
        .frame(width: 237, height: 309)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
//        .blendMode(.darken)
    }
}
struct Tab8: View {
    @State var z=100
    @State var i=52
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
        
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
            }
    }
    var body: some View {
        GeometryReader{ geo in
            RoundedRectangle(cornerRadius: 10)
                       .foregroundColor(.pink)
                       .frame(width: 100, height: 100)
                       .position(location)
                       .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.location = value.location
                                }
                       )
                .onHover{value in
                     print(value,"pes")
                }
            RoundedRectangle(cornerRadius: 10)
                       .foregroundColor(.pink)
                       .frame(width: 100, height: 100)
                       .position(x: 200, y: 200)
//                       .gesture(
//                        LongPressGesture(minimumDuration: 0, maximumDistance: 0)
//                            .onEnded{value in
//                                print("pes")
//                            }
//                       )
                       .onHover{value in
                            print(value)
                       }
        }.frame(width: 500, height: 500)
    }
}
//MARK PPPPPP
struct Temp: View {
        let img1url = Bundle.main.url(forResource: "Images/5", withExtension: "jpeg")
        let img2url = Bundle.main.url(forResource: "Images/6", withExtension: "jpeg")
        let img3url = Bundle.main.url(forResource: "Images/7", withExtension: "png")
        let img4url = Bundle.main.url(forResource: "Images/8", withExtension: "png")
        
    
    var body: some View {
        HStack {
            VStack {
                DragableImage(url: img1url!)
                
                DragableImage(url: img3url!)
            }
            
            VStack {
                DragableImage(url: img2url!)
                
                DragableImage(url: img4url!)
            }
            
            DroppableArea()
        }.padding(40)
    }
    
    struct DragableImage: View {
        let url: URL
        
        var body: some View {
            Image(nsImage: NSImage(byReferencing: url))
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .padding(2)
                .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
                .shadow(radius: 3)
                .padding(4)
                .onDrag { return NSItemProvider(object: self.url as NSURL) }
        }
    }
    
    struct DroppableArea: View {
        @State private var imageUrls: [Int: URL] = [:]
        @State private var active = 0
        
        var body: some View {
            let dropDelegate = MyDropDelegate(imageUrls: $imageUrls, active: $active)
            
            return VStack {
                HStack {
                    GridCell(active: self.active == 1, url: imageUrls[1])
                    
                    GridCell(active: self.active == 3, url: imageUrls[3])
                }
                
                HStack {
                    GridCell(active: self.active == 2, url: imageUrls[2])

                    GridCell(active: self.active == 4, url: imageUrls[4])
                }
                
            }
            .background(Rectangle().fill(Color.gray))
            .frame(width: 300, height: 300)
            .onDrop(of: ["public.file-url"], delegate: dropDelegate)
            
        }
    }
    
    struct GridCell: View {
        let active: Bool
        let url: URL?
        
        var body: some View {
            let img = Image(nsImage: url != nil ? NSImage(byReferencing: url!) : NSImage())
                .resizable()
                .frame(width: 150, height: 150)
            
            return Rectangle()
                .fill(self.active ? Color.green : Color.clear)
                .frame(width: 150, height: 150)
                .overlay(img)
        }
    }
    
    struct MyDropDelegate: DropDelegate {
        @Binding var imageUrls: [Int: URL]
        @Binding var active: Int
        
        func validateDrop(info: DropInfo) -> Bool {
            return info.hasItemsConforming(to: ["public.file-url"])
        }
        
        func dropEntered(info: DropInfo) {
            NSSound(named: "Morse")?.play()
        }
        
        func performDrop(info: DropInfo) -> Bool {
            NSSound(named: "Submarine")?.play()
            
            let gridPosition = getGridPosition(location: info.location)
            self.active = gridPosition
            
            if let item = info.itemProviders(for: ["public.file-url"]).first {
                item.loadItem(forTypeIdentifier: "public.file-url", options: nil) { (urlData, error) in
                    DispatchQueue.main.async {
                        if let urlData = urlData as? Data {
                            self.imageUrls[gridPosition] = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                        }
                    }
                }
                
                return true
                
            } else {
                return false
            }

        }
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            self.active = getGridPosition(location: info.location)
                        
            return nil
        }
        
        func dropExited(info: DropInfo) {
            self.active = 0
        }
        
        func getGridPosition(location: CGPoint) -> Int {
            if location.x > 150 && location.y > 150 {
                return 4
            } else if location.x > 150 && location.y < 150 {
                return 3
            } else if location.x < 150 && location.y > 150 {
                return 2
            } else if location.x < 150 && location.y < 150 {
                return 1
            } else {
                return 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
func Pes(_ i:inout Int) {
    i+=1
}
