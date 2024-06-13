import pandas as pd
import os
from langdetect import detect, DetectorFactory
from langdetect.lang_detect_exception import LangDetectException

DetectorFactory.seed = 0

def determine_developer_type(title, headline):
    title = title.lower() if pd.notna(title) else ""
    headline = headline.lower() if pd.notna(headline) else ""
    text = title + " " + headline

    try:
        language = detect(text)
    except LangDetectException:
        language = 'unknown'
    
    # 定义多语言关键字列表
    backend_keywords = {
        'en': ['backend', 'server-side', 'api', 'database', 'server'],
        'ko': ['후단', '서버사이드', '백엔드', '서버', '데이터베이스'],
        'es': ['backend', 'lado del servidor', 'api', 'base de datos', 'servidor'],
        
    }
    
    frontend_keywords = {
        'en': ['frontend', 'client-side', 'ui', 'ux', 'html', 'css', 'javascript'],
        'ko': ['전단', '클라이언트사이드', '프론트엔드', 'ui', 'ux', 'html', 'css', '자바스크립트'],
        'es': ['frontend', 'lado del cliente', 'ui', 'ux', 'html', 'css', 'javascript'],
       
    }
    
    fullstack_keywords = {
        'en': ['fullstack', 'full stack'],
        'ko': ['풀스택', '풀 스택'],
        'es': ['fullstack', 'full stack'],
        
    }
    
    if language in backend_keywords and any(keyword in text for keyword in backend_keywords[language]):
        return '후단'
    elif language in frontend_keywords and any(keyword in text for keyword in frontend_keywords[language]):
        return '전단'
    elif language in fullstack_keywords and any(keyword in text for keyword in fullstack_keywords[language]):
        return '풀스택'
    else:
        return '기타'

filename = 'udemy_courses.csv'
if not os.path.exists(filename):
    print(f"파일 {filename}이(가) 없습니다.")
else:
    df = pd.read_csv(filename, low_memory=False)
    print(f"파일 {filename}이(가) 로드되었으며 {df.shape[0]}행 {df.shape[1]}열을 포함하고 있습니다.")

    if 'title' in df.columns:
        print("개발자 유형 열 추가를 시작합니다...")
        df['developer_type'] = df.apply(lambda x: determine_developer_type(x['title'], x.get('headline', '')), axis=1)
        print("개발자 유형 열이 추가되었습니다.")
    else:
        print(f"{filename}에 제목 열이 없습니다.")
    
    df.to_csv(filename, index=False)
    print(f"{filename}이(가) 업데이트되어 저장되었습니다.")
