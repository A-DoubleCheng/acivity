package com.activity.method;

import org.hibernate.SQLQuery;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.EntityManagerFactoryUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.List;


/**
 * Created by Administrator on 2017/5/16.
 */
@Service
public class StartMethod {
    @Autowired
    private EntityManager entityManager;

    @Transactional
    public void setPrice(String userphone, String price){
        String sql = "INSERT INTO activity_guessprice VALUES (null,:userphone,:price,now())";
        entityManager.createNativeQuery(sql).setParameter("userphone",userphone).setParameter("price",price).executeUpdate();

        EntityManagerFactoryUtils.closeEntityManager(entityManager);
    }

    public List<HashMap> searchUserPhone(String userphone){
        String sql = "SELECT  * FROM activity_guessprice WHERE tel=:tel";
        Query query = entityManager.createNativeQuery(sql).setParameter("tel", userphone);
        query.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List<HashMap> list = query.getResultList();
        EntityManagerFactoryUtils.closeEntityManager(entityManager);
        return list;
    }

    public List<HashMap> searchNowPrice(){
        String sql = "SELECT  * FROM activity_price WHERE id=1";
        Query query = entityManager.createNativeQuery(sql);
        query.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List<HashMap> list = query.getResultList();
        EntityManagerFactoryUtils.closeEntityManager(entityManager);
        return list;
    }

    public HashMap<String, String> toSearchNum(){
        HashMap<String, String> hashMap = new HashMap<>();
        String sql1 = "SELECT count(*) as count1 FROM activity_guessprice WHERE price > 15001";
        String sql2 = "SELECT count(*) as count2 FROM activity_guessprice WHERE price > 14501 and price < 15000";
        String sql3 = "SELECT count(*) as count3 FROM activity_guessprice WHERE price > 14001 and price < 14500";
        String sql4 = "SELECT count(*) as count4 FROM activity_guessprice WHERE price > 13501 and price < 14000";
        String sql5 = "SELECT count(*) as count5 FROM activity_guessprice WHERE price < 13500";

        Query query1 = entityManager.createNativeQuery(sql1);
        query1.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list1 = query1.getResultList();

        Query query2 = entityManager.createNativeQuery(sql2);
        query2.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list2 = query2.getResultList();

        Query query3 = entityManager.createNativeQuery(sql3);
        query3.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list3 = query3.getResultList();

        Query query4 = entityManager.createNativeQuery(sql4);
        query4.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list4 = query4.getResultList();

        Query query5 = entityManager.createNativeQuery(sql5);
        query5.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list5 = query5.getResultList();

        EntityManagerFactoryUtils.closeEntityManager(entityManager);

        ;

        hashMap.put("count1",((HashMap<String, String>) list1.get(0)).get("count1"));
        hashMap.put("count2",((HashMap<String, String>) list2.get(0)).get("count2"));
        hashMap.put("count3",((HashMap<String, String>) list3.get(0)).get("count3"));
        hashMap.put("count4",((HashMap<String, String>) list4.get(0)).get("count4"));
        hashMap.put("count5",((HashMap<String, String>) list5.get(0)).get("count5"));

        return hashMap;
    }

    @Transactional
    public void setPriceOnly(String price){
        String sql = "INSERT INTO activity_guessprice VALUES (null,'',:price,now())";
        entityManager.createNativeQuery(sql).setParameter("price",price).executeUpdate();

        EntityManagerFactoryUtils.closeEntityManager(entityManager);
    }
}
