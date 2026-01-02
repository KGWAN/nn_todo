//
//  PersistenceController.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/24/25.
//

import CoreData

struct PersistenceController {
    // 앱 전체에서 사용할 수 있는 싱글턴 인스턴스
    static let shared = PersistenceController()

    // 개발/테스트 목적으로 사용할 프리뷰 인스턴스
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true, isPreview: true)
        
        // 💡 기본 데이터 생성
        var cnt = 0
        Dummy.listKategorie.forEach { k in
            let new = Kategorie.createNewKategorie(result.container.viewContext)
            new.name = k
            new.sort_num = String(cnt)
            cnt += 1
        }
        let work = Work.createNew(result.container.viewContext)
        
        do {
            try result.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("초기 데이터 저장 실패: \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // Core Data 컨테이너
    let container: NSPersistentContainer
    
    let isPreview: Bool

    private init(inMemory: Bool = false, isPreview: Bool = false) {
        self.isPreview = isPreview
        
        // Core Data 모델 파일(.xcdatamodeld)의 이름을 넣어줍니다.
        // 예를 들어, 모델 파일 이름이 MyAppModel.xcdatamodeld라면 "MyAppModel"을 사용합니다.
        container = NSPersistentContainer(name: "DataModel")
        
        // 삭제 로직 data model 수정 후에만 적용
//        if isPreview {
//            let description = container.persistentStoreDescriptions.first!
//            // db 삭제
//            if let storeURL = description.url {
//                do {
//                    try FileManager.default.removeItem(at: storeURL)
//                    print("✅ Core Data store 삭제 완료")
//                } catch {
//                    print("⚠️ store 삭제 실패: \(error)")
//                }
//            }
//        }
        
        // auto migration setting
        container.persistentStoreDescriptions.first?.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = true
        
        if inMemory {
            // 인메모리 저장소 설정 (프리뷰/테스트용)
            container.persistentStoreDescriptions.first!.type = NSInMemoryStoreType
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // 심각한 오류 발생 시 앱을 중단하거나 적절히 처리해야 합니다.
                fatalError("Core Data 스토어 로드 실패: \(error), \(error.userInfo)")
            }
        })
        // Context 병합 정책 설정
        container.viewContext.automaticallyMergesChangesFromParent = !isPreview
    }
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            Log.logError("데이터 저장 실패", error: nsError, key: "PersistenceController")
        }
    }
    
    // 초기 데이터 생성 함수
    func createInitialData(_ context: NSManagedObjectContext, completion: @escaping () -> Void) {
        // 💡 기본 데이터 생성
        createInitialKategorieData(context)
        
        save(context)
    }
    
    func createInitialKategorieData(_ context: NSManagedObjectContext) {
        var cnt = 0
        Dummy.listKategorie.forEach { k in
            let newItem = Kategorie(context: context)
            newItem.id = UUID()
            newItem.name = k
            newItem.color = nil
            newItem.generate_date = Date()
            newItem.is_hidden = false
            newItem.sort_num = String(cnt)
            cnt += 1
        }
    }
    
}
