//
//  Textures.h
//  AsteroidJumper
//
//  Created by Taylor Triggs on 2/11/13.
//  Copyright 2013 Cal State Channel Islands. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Textures : NSObject
{
    GLuint	  texture[1];
    NSString  *filename;
}

@property (nonatomic, retain) NSString *filename;

- (id)initWithFilename:(NSString *)filename;

- (void)bind_texture;

@end