package com.xoyar.cms.test;

import com.github.pagehelper.PageInfo;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.mapper.UserMapper;
import com.xoyar.cms.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserServiceTest {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserService userService;

    @Test
    public void userPageHelperTest(){
        PageInfo<User> pageInfo = userService.getUserPage(1,5);
        List<User> list = pageInfo.getList();

        for (User user:list){
            System.out.println(user);
        }
    }

}
