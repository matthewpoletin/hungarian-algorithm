function [iMat] = GeneralStage(iMatSize,iMat)
%�������� ����. �� ���� �������� ������� ������� � ���� �������
%PlusItemsCol - ������, ��������������� ���������� �������. ���� ������� =
%-1, �� ������� �� �������, ����� ������ ������ ����������� 0*;
%iPlusNull - ������ ���;
%arrComRow - ������ ���������� �����. 0 - ������ �� ��������,1 - ��������;
%iComRow - ���� � i �������� 0';
%iComCol - ���� � j �������� 0';
%iterCount - ������� ��������;
%bHasUnmarkedNull - True:����� ������������ ���� 0/False:���;
%bHasMarkedNullInRow - True:� ���������� ������ ���� 0*/False:���;

try
    global bDeb;
    global InputMat;
    if bDeb
        cprintf('*blue', '�������� ����:\n');
    end
    %���������� �������������� ���
    [PlusItemsCol,iPlusNull] = GetNullIndx(iMatSize,iMat);
    if bDeb
        FirstShowCINMatrix(iPlusNull,PlusItemsCol,iMat);
    end
    %� iComRow,iComCol - ���� ��� �������� ��������� �� �������
    iComRow = [];
    iComCol = [];
    arrComRow = zeros(1,iMatSize); 
    %��������� ����, ���� ���������� ���������� ����� �� ������ �����
    %����������� �������
    iterCount = 1;
    
    %������ ��� ����� ����������� �������?
    while iPlusNull < iMatSize       
        %����� ������������ ��������� ���� 0?
        [bHasUnmarkedNull,iComRow,iComCol] = CheckUnmarkedNull(PlusItemsCol,iMat,arrComRow,iComRow,iComCol);              
        %��, ����� ������������ ��������� ���� 0
        if bHasUnmarkedNull
            if bDeb
                ShowComMatrix(PlusItemsCol,iMat,iterCount,iComRow,iComCol);
            end
            %� ����� ������ � 0' ���� 0*?
            [bHasMarkedNullInRow] = FindMarkedNullInRow(PlusItemsCol,iComRow);
            %��, � ������ � 0' ���� 0*
            if bHasMarkedNullInRow
                %�������� ��������� �� �������. ��������� ������              
                [PlusItemsCol,arrComRow] = ChangeMarks(PlusItemsCol,iComCol,iComRow,arrComRow);
                if bDeb
                    fprintf('\n� ������ � ������� ����� ���� ���������� ����\n');
                    ShowCINMatrix(PlusItemsCol,arrComRow,iMat,iComRow,iComCol);
                end 
            %���, � ������ � 0' ��� 0*
            else
                %������ ��������� �� �����, ����� ��������� ��������
                [PlusItemsCol,arrComRow,iComCol,iComRow]=CreateNewCIN(PlusItemsCol,arrComRow,iComCol,iComRow);
                if bDeb
                    fprintf('\n� ������ � ������� ����� ��� ����������� ����\n');
                    FirstShowCINMatrix(iPlusNull,PlusItemsCol,iMat);
                end
            end
        %���, ����� ������������ ��������� ��� 0.
        else 
            iMat = UpgradeMatrix(iMat,PlusItemsCol,arrComRow);
            if bDeb
                fprintf('\n����� ������������ ��������� ��� ����. �������� �������\n');
                ShowCINMatrix(PlusItemsCol,arrComRow,iMat,iComRow,iComCol);
            end
        end
        %������� ��������� ���
        iPlusNull = 0;
        for i=1:length(PlusItemsCol)
            if PlusItemsCol(i)~=-1
                iPlusNull = iPlusNull + 1;
            end
        end
        iPlusNull = iPlusNull + length(iComCol);
        if bDeb
            fprintf('\n���������� ������� ���������: %.1d\n',iPlusNull);
        end
        iterCount = iterCount + 1;
    end        
    
    %���������� ������������ �������
    [iMat,OptSumm] = OptDecision(PlusItemsCol);
    ShowOptDecision(iMat,OptSumm,PlusItemsCol);
catch
   fprintf('������ � �������� ����� ���������\n'); 
end
end