package com.xoyar.cms.test;

import com.xoyar.cms.mapper.UserMapper;
import com.xoyar.cms.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserTest {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserService userService;

    @Test
    public void userMapperTest(){
        System.out.println(userMapper.getUserById(1));
    }

    @Test
    public void userServiceTest(){

        System.out.println(userService.getUserById(1));
    }
}
