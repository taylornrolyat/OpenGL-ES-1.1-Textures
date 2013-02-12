OpenGL-ES-1.1-Textures
======================

Texture Loader class for OpenGL ES 1.1

HOW TO USE: 

In the header file:

      @class Textures;
      
      @property (nonatomic, retain) Textures *sky_texture;

In the main file:
      
      #import "Textures.h"
      
      @synthesize sky_texture;
      
      Textures *obj = [[Textures alloc] initWithFilename:@"space_texture.jpg"];
   
      self.sky_texture = obj;
      [obj release];
