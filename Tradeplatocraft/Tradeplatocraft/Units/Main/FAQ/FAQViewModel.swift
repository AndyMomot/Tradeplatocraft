//
//  FAQViewModel.swift
//  Tradeplatocraft
//
//  Created by Andrii Momot on 17.02.2025.
//

import Foundation

extension FAQView {
    final class ViewModel: ObservableObject {
        let faqItems: [FAQItem] = [
            .init(
                title: "Zacznij od wyboru materiałów i narzędzi do personalizacji",
                text: "Przed rozpoczęciem tworzenia spersonalizowanych produktów, zastanów się, jakie materiały będą Ci potrzebne. Wybierz odpowiednią odzież, obuwie lub gadżety, a następnie dobierz farby, tkaniny, akcesoria do malowania czy nadruków. Pamiętaj, że jakość materiałów ma kluczowe znaczenie dla ostatecznego wyglądu Twojego merchu."),
            .init(
                title: "Ustal cenę produktów, uwzględniając koszty",
                text: "Kiedy już masz materiały, przemyśl, jaką cenę chcesz ustalić dla swojego produktu. Weź pod uwagę koszt zakupu materiałów, robocizny oraz inne wydatki, takie jak narzędzia i maszyny. Następnie określ marżę, która pozwoli Ci osiągnąć zysk. Kalkulator kosztów w aplikacji pomoże Ci dokładnie obliczyć, ile musisz zarobić na każdym produkcie, aby pokryć koszty i osiągnąć pożądany zysk."),
            .init(
                title: "Personalizuj produkty zgodnie z trendami i preferencjami klientów",
                text: "Tworząc spersonalizowany merchandising, warto śledzić najnowsze trendy i dostosowywać swoje projekty do aktualnych gustów klientów. Dodanie osobistych akcentów, takich jak imiona, cytaty czy unikalne grafiki, zwiększy atrakcyjność Twoich produktów."),
            .init(
                title: "Monitoruj koszty i zysk z każdej transakcji",
                text: "Zanim zaczniesz sprzedaż, upewnij się, że masz dokładny obraz kosztów produkcji. Aplikacja pomoże Ci śledzić, ile kosztuje każdy etap tworzenia produktów, począwszy od zakupu materiałów, przez produkcję, aż po marketing i sprzedaż. Dzięki temu będziesz wiedzieć, który produkt jest najbardziej opłacalny i jakie koszty należy zoptymalizować, aby zwiększyć zysk."),
            .init(
                title: "Skup się na sprzedaży online i promocji swoich produktów",
                text: "Po stworzeniu spersonalizowanego merchu, czas na sprzedaż. Platformy online, takie jak sklepy internetowe czy media społecznościowe, to doskonałe miejsca, by dotrzeć do szerokiej grupy klientów. Korzystaj z kampanii promujących Twoje produkty, oferuj rabaty czy ograniczone edycje, które przyciągną uwagę."),
            .init(
                title: "Zadbaj o jakość zdjęć i wizualizacji produktów",
                text: "Aby Twoje produkty wyglądały atrakcyjnie w oczach klientów, inwestuj w dobrej jakości zdjęcia. Aplikacja pozwala na tworzenie wizualizacji, dzięki którym łatwiej zaprezentujesz swój merch w atrakcyjny sposób. Zdjęcia 'przed' i 'po' personalizacji, a także zdjęcia gotowych produktów w użyciu, pomogą w budowaniu pozytywnego wrażenia u klientów."),
            .init(
                title: "Analizuj sprzedaż i dopasowuj ofertę do potrzeb rynku",
                text: "Zawsze monitoruj, które produkty są najbardziej popularne wśród Twoich klientów. Aplikacja pomoże Ci analizować dane sprzedaży, dzięki czemu dowiesz się, które projekty przynoszą największy zysk. Regularne śledzenie wyników sprzedaży pozwoli Ci dopasować ofertę do oczekiwań rynku i skupić się na produktach, które cieszą się największym zainteresowaniem."),
            .init(
                title: "Utrzymuj relacje z klientami i zdobywaj opinie",
                text: "Nie zapomnij o budowaniu długoterminowych relacji z klientami. Zbieraj opinie na temat swoich produktów, dostosowuj ofertę do ich potrzeb i życzeń. Dzięki aplikacji możesz zapisywać notatki o preferencjach klientów i ich specjalnych życzeniach, co pomoże Ci lepiej dopasować przyszłe zamówienia do ich oczekiwań."),
        ]
    }
}

extension FAQView {
    struct FAQItem: Identifiable {
        private(set) var id = UUID().uuidString
        let title: String
        let text: String
    }
}
