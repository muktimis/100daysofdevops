from sqlalchemy import create_engine, Column, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime

engine = create_engine('sqlite:///uploads.db')
Base = declarative_base()

class Upload(Base):
    __tablename__ = 'uploads'
    filename = Column(String, primary_key=True)
    s3_url = Column(String)
    upload_time = Column(DateTime, default=datetime.utcnow)
    ip = Column(String)

Session = sessionmaker(bind=engine)
session = Session()

def init_db():
    Base.metadata.create_all(engine)

def save_metadata(data):
    upload = Upload(**data)
    session.add(upload)
    session.commit()
