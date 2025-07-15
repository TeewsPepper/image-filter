/** Exported memory */
export declare const memory: WebAssembly.Memory;
/** src/assembly/index/PIXEL_PTR */
export declare const PIXEL_PTR: {
  /** @type `i32` */
  get value(): number
};
/**
 * src/assembly/index/getPixelPtr
 * @returns `i32`
 */
export declare function getPixelPtr(): number;
/**
 * src/assembly/index/grayscale
 * @param ptr `i32`
 * @param width `i32`
 * @param height `i32`
 */
export declare function grayscale(ptr: number, width: number, height: number): void;
/**
 * src/assembly/index/sepia
 * @param ptr `i32`
 * @param width `i32`
 * @param height `i32`
 */
export declare function sepia(ptr: number, width: number, height: number): void;
/**
 * src/assembly/index/invert
 * @param ptr `i32`
 * @param width `i32`
 * @param height `i32`
 */
export declare function invert(ptr: number, width: number, height: number): void;
/**
 * src/assembly/index/blur
 * @param ptr `i32`
 * @param width `i32`
 * @param height `i32`
 */
export declare function blur(ptr: number, width: number, height: number): void;
/**
 * src/assembly/index/sharpen
 * @param ptr `i32`
 * @param width `i32`
 * @param height `i32`
 */
export declare function sharpen(ptr: number, width: number, height: number): void;
