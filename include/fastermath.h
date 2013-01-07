#ifndef FASTERMATH_H
#define FASTERMATH_H

#ifdef __cplusplus
#define FM_EXPORT_DECL extern "C"
#else
#define FM_EXPORT_DECL extern
#endif

#ifdef __GNUC__
#define FM_FUNC_DECL1(type,name) \
    FM_EXPORT_DECL type name(type) __attribute__ ((pure,nothrow))
#else
#define FM_FUNC_DECL1(type,name) \
    FM_EXPORT_DECL type name(type)
#endif

/* prototypes for the exported interface */
FM_FUNC_DECL1(double,fm_exp);
FM_FUNC_DECL1(double,fm_exp2);
FM_FUNC_DECL1(double,fm_exp10);

FM_FUNC_DECL1(double,fm_log2);

FM_FUNC_DECL1(float,fm_expf);
FM_FUNC_DECL1(float,fm_exp2f);
FM_FUNC_DECL1(float,fm_exp10f);

FM_FUNC_DECL1(double,fm_exp_alt);
FM_FUNC_DECL1(float,fm_expf_alt);
FM_FUNC_DECL1(double,fm_exp10_alt);
FM_FUNC_DECL1(float,fm_exp10f_alt);

#endif /* FASTERMATH_H */

/* 
 * Local Variables:
 * mode: c
 * compile-command: "make"
 * c-basic-offset: 4
 * fill-column: 76 
 * indent-tabs-mode: nil 
 * End: 
 */