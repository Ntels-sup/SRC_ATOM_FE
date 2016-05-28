package com.ntels.avocado.exception;

import com.ntels.ncf.exception.MessageException;

public class AtomException extends MessageException {
	
    private static final long serialVersionUID = -3392195539986518720L;
	
	public AtomException(String key) {
        super(key);
    }
    public AtomException(String key, Throwable cause) {
        super(key, cause);
    }
    public AtomException(String key, Object[] args) {
        super(key, args);
    }
    public AtomException(String key, Object[] args, Throwable cause) {
        super(key, args, cause);
    }
}
