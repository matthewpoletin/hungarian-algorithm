function [iMat] = GeneralStage(iMatSize,iMat)
%�������� ����. �� ���� �������� ������� ������� � ���� �������
%try
    global bDeb;
    [PlusItemsCol,PlusItemsRow,iPlusNull] = GetNullIndx(iMatSize,iMat);
    %PlusColumn - ����� �������� ������������� ������ �������
    %���� i-� ������ <>"-1", �� � ��� ���������� ����� ������ � ���
    %PlusItemsRow -||- ��� ������
FirstShowCINMatrix(iPlusNull,PlusItemsCol,[-2 -2],iMat);

    %��������� ����, ���� ���������� ���������� ����� �� ������ �����
    %����������� �������
    while iPlusNull < iMatSize
        %����� ����, ����� ������������ ���������
        [bHasUnmarkedNull,arrComItems] = CheckUnmarkedNull(iMat,PlusItemsCol);
        %���� ����� ������������ ��������� ����, ���������� ��� ������ � 
        %������  arrComItems - � (1) ������, � (2) ������� �������� ��������;
        %������� ������� PlusItemsCol, ��������������� ������� ����������� ����,
        %�������� � ����� ������ � ��������� ����� ��������� � "-1"
        if bHasUnmarkedNull
            ShowComMatrix(PlusItemsCol,arrComItems,iMat);
            [PlusItemsCol,iPlusNull] = ChangePlus(PlusItemsCol,arrComItems);
            ShowCINMatrix(iPlusNull,PlusItemsCol,arrComItems,iMat);
        end
       

    end
 FirstShowCINMatrix(iPlusNull,PlusItemsCol,[-2 -2],iMat);
%catch
%   fprintf('������ � �������� ����� ���������\n'); 
%end
end

