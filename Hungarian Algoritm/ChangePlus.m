function [PlusItems,iPlusNull] = ChangePlus(PlusItems,arrComItems,delColForOutput)
%��������� "+" ������ � 0', ������ "+" �� ������� � 0*

%������������� � "-1" ������� ��� �������, ��������������� ����� ����������
%������
for i = 1:length(PlusItems)
    if PlusItems(i) == arrComItems(1)
        PlusItems(i) = -1;
        delColForOutput = PlusItems(i); %��� ������ �������� �������, � 
                                        %�������� ����� ������� "+"
    end
end

%���������� ����� ����� ������ � ��������������� ������� ����������
%���������
    PlusItems(arrComItems(2)) = arrComItems(1);
iPlusNull = 0;

%������� ���������� ������� ���������� ���������
for i = 1:length(PlusItems)
    if PlusItems(i) ~= -1
        iPlusNull = iPlusNull + 1;
    end
end
end

