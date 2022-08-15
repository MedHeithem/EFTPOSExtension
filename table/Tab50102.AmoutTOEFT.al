table 50102 "Amout TO EFT"
{
    Caption = 'Amout TO EFT';
    DataPerCompany = false;
    LinkedObject = false;
    TableType = Normal;
    DataClassification = ToBeClassified;
    PasteIsValid = true;

    fields
    {
        field(1; SlipNo; Text[50])
        {
            Caption = 'SlipNo';
            DataClassification = ToBeClassified;
        }
        field(2; ClientID; Text[50])
        {
            Caption = 'ClientID';
            DataClassification = ToBeClassified;
        }
        field(3; CurrencyCode; Code[10])
        {
            Caption = 'CurrencyCode';
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(5; CashBack; Decimal)
        {
            Caption = 'CashBack';
            DataClassification = ToBeClassified;
        }
        field(6; Vat; Decimal)
        {
            Caption = 'Vat';
            DataClassification = ToBeClassified;
        }
        field(7; CustomData; Text[50])
        {
            Caption = 'CustomData';
            DataClassification = ToBeClassified;
        }
        field(8; Satus; Option)
        {
            Caption = 'Satus';
            OptionCaption = 'Init,Appouved,Fail';
            OptionMembers = "Init","Appouved","Fail";
            DataClassification = ToBeClassified;
        }
        field(9; "DateTime"; DateTime)
        {
            Caption = 'DateTime';
            DataClassification = ToBeClassified;

        }
        field(10; EntryNo; Integer)
        {
            Caption = 'EntryNo';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(11; Reponse; Text[50])
        {
            Caption = 'Reponse';
            DataClassification = ToBeClassified;
        }
        field(12; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store"."No.";
            DataClassification = ToBeClassified;
        }
        field(13; "POS Terminal No."; Code[10])
        {
            Caption = 'POS Terminal No.';
            TableRelation = "LSC POS Terminal"."No.";
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }
    procedure InsertData(pSlipNo: Text; pClientID: Text; pCurrencyCode: Code[10]; pAmount: Decimal; pCashBack: Decimal; pVat: Decimal; pCustomData: Text; pStore: Code[20]; pTerminal: Code[20])
    var
        myInt: Integer;
    begin
        INIT;
        SlipNo := pSlipNo;
        ClientID := pClientID;
        CurrencyCode := pCurrencyCode;
        Amount := pAmount;
        CashBack := pCashBack;
        Vat := pVat;
        CustomData := pCustomData;
        "Store No." := pStore;
        "POS Terminal No." := pTerminal;
        "DateTime" := CURRENTDATETIME;
        INSERT(TRUE);
    end;
}
