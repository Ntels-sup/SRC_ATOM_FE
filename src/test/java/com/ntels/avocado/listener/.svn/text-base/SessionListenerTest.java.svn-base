package com.ntels.avocado.listener;

import static org.junit.Assert.fail;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.SessionUser;

public class SessionListenerTest {

    private Logger logger = Logger.getLogger(this.getClass());
    
    private final HttpSession session = mock(HttpSession.class);
    private final HttpSessionEvent hse = mock(HttpSessionEvent.class);
    private final SessionListener sessionListener = new SessionListener();
    
    
    @Ignore
    public void testSessionCreated() {
        fail("Not yet implemented");
    }

    @Test
    @Transactional
    public void testSessionDestroyed() {
        
        SessionUser sessionUser = new SessionUser();
        
        logger.debug( "testSessionDestroyed()..." );
        when(hse.getSession()).thenReturn(session);
        
        session.setAttribute(Consts.USER.SESSION_USER, new SessionUser());
        
        sessionListener.sessionDestroyed(hse);  
    }

}
