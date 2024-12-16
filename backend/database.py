from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(DATABASE_URL)
Base = declarative_base()
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

class ESGScore(Base):
    __tablename__ = "esg_scores"
    id = Column(Integer, primary_key=True, index=True)
    data = Column(String)
    score = Column(String)

def init_db():
    Base.metadata.create_all(bind=engine)