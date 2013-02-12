//
//  Textures.m
//  AsteroidJumper
//
//  Created by Taylor Triggs on 2/11/13.
//  Copyright 2013 Cal State Channel Islands. All rights reserved.
//

#import "Textures.h"

@implementation Textures
@synthesize filename; 

- (id)initWithFilename:(NSString *)inFilename
{
	if ((self = [super init]))
	{
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
        
		self.filename = inFilename;
		
        glBlendFunc(GL_ONE, GL_SRC_COLOR);
        
        glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
        
        // Bind the number of textures we need, in this case one.
        glGenTextures(1, &texture[0]); // create a texture obj, give unique ID
        glBindTexture(GL_TEXTURE_2D, texture[0]); // load our new texture name into the current texture
        
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
        
        // We repeat the pixels in the edge of the texture, it will hide that 1px wide line at the edge of the cube
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
        // We do it for vertically and horizontally (previous line)
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE);

		
		NSString *extension = [filename pathExtension];
		NSString *baseFilenameWithExtension = [filename lastPathComponent];
		NSString *baseFilename = [baseFilenameWithExtension substringToIndex:[baseFilenameWithExtension length] - [extension length] - 1];
        
		NSString *path = [[NSBundle mainBundle] pathForResource:baseFilename ofType:extension];
		NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
        
        UIImage *image = [[UIImage alloc] initWithData:texData];
        if (image == nil)
            return nil;
        
        GLuint width = CGImageGetWidth(image.CGImage);
        GLuint height = CGImageGetHeight(image.CGImage);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        void *imageData = malloc( height * width * 4 ); // times 4 because will write one byte for rgb and alpha
        CGContextRef cgContext = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
        
        CGColorSpaceRelease(colorSpace);
        CGContextClearRect(cgContext, CGRectMake(0, 0, width, height));
        CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height), image.CGImage);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
        
        CGContextRelease(cgContext);
        
        free(imageData);
        [image release];
        [texData release];
	}
	return self;
}

- (void)bind_texture
{
	glBindTexture(GL_TEXTURE_2D, texture[0]);
}

- (void)dealloc
{
	glDeleteTextures(1, &texture[0]);
	[filename release];
	[super dealloc];
}
@end
