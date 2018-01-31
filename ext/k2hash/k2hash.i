%module k2hash
%{
#include "k2hash/k2hash.h"
%}

%include "typemaps.i"

%newobject k2h_get_str_direct_value;

%rename(k2h_get_str_direct_subkeys) _k2h_get_str_direct_subkeys;
%inline %{
  VALUE _k2h_get_str_direct_subkeys(k2h_h handle, const char* pkey)
  {
    char** ppSKeyArray = k2h_get_str_direct_subkeys(handle, pkey);

    char** pptmp;
    VALUE r = rb_ary_new();

    short i = 0;
    for(pptmp = ppSKeyArray; pptmp && *pptmp; pptmp++){
        rb_ary_push(r, rb_str_new2(ppSKeyArray[i]));
        i++;
    }

    k2h_free_keyarray(ppSKeyArray);
    return r;
  }
%}

extern void k2h_bump_debug_level(void);
extern void k2h_set_debug_level_silent(void);
extern void k2h_set_debug_level_error(void);
extern void k2h_set_debug_level_warning(void);
extern void k2h_set_debug_level_message(void);
extern bool k2h_set_debug_file(const char* filepath);
extern bool k2h_unset_debug_file(void);
extern bool k2h_load_debug_env(void);
extern bool k2h_set_bumup_debug_signal_user1(void);
#
extern bool k2h_load_hash_library(const char* libpath);
extern bool k2h_unload_hash_library(void);
extern bool k2h_load_transaction_library(const char* libpath);
extern bool k2h_unload_transaction_library(void);
#
extern bool k2h_create(const char* filepath, int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern k2h_h k2h_open(const char* filepath, bool readonly, bool removefile, bool fullmap, int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern k2h_h k2h_open_rw(const char* filepath, bool fullmap, int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern k2h_h k2h_open_ro(const char* filepath, bool fullmap, int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern k2h_h k2h_open_tempfile(const char* filepath, bool fullmap, int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern k2h_h k2h_open_mem(int maskbitcnt, int cmaskbitcnt, int maxelementcnt, size_t pagesize);
extern bool k2h_close(k2h_h handle);
extern bool k2h_close_wait(k2h_h handle, long waitms);
#
extern bool k2h_transaction(k2h_h handle, bool enable, const char* transfile);
extern bool k2h_transaction_prefix(k2h_h handle, bool enable, const char* transfile, const unsigned char* pprefix, size_t prefixlen);
extern bool k2h_transaction_param(k2h_h handle, bool enable, const char* transfile, const unsigned char* pprefix, size_t prefixlen, const unsigned char* pparam, size_t paramlen);
extern bool k2h_transaction_param_we(k2h_h handle, bool enable, const char* transfile, const unsigned char* pprefix, size_t prefixlen, const unsigned char* pparam, size_t paramlen, const time_t* expire);
extern bool k2h_enable_transaction(k2h_h handle, const char* transfile);
extern bool k2h_enable_transaction_prefix(k2h_h handle, const char* transfile, const unsigned char* pprefix, size_t prefixlen);
extern bool k2h_enable_transaction_param(k2h_h handle, const char* transfile, const unsigned char* pprefix, size_t prefixlen, const unsigned char* pparam, size_t paramlen);
extern bool k2h_enable_transaction_param_we(k2h_h handle, const char* transfile, const unsigned char* pprefix, size_t prefixlen, const unsigned char* pparam, size_t paramlen, const time_t* expire);
extern bool k2h_disable_transaction(k2h_h handle);
extern int k2h_get_transaction_archive_fd(k2h_h handle);
extern bool k2h_load_archive(k2h_h handle, const char* filepath, bool errskip);
extern bool k2h_put_archive(k2h_h handle, const char* filepath, bool errskip);
extern int k2h_get_transaction_thread_pool(void);
extern bool k2h_set_transaction_thread_pool(int count);
extern bool k2h_unset_transaction_thread_pool(void);
#
extern bool k2h_set_common_attr(k2h_h handle, const bool* is_mtime, const bool* is_defenc, const char* passfile, const bool* is_history, const time_t* expire);
extern bool k2h_clean_common_attr(k2h_h handle);
extern bool k2h_add_attr_plugin_library(k2h_h handle, const char* libpath);
extern bool k2h_add_attr_crypt_pass(k2h_h handle, const char* pass, bool is_default_encrypt);
extern bool k2h_print_attr_version(k2h_h handle, FILE* stream);
extern bool k2h_print_attr_information(k2h_h handle, FILE* stream);
#
extern bool k2h_get_value(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength);
extern unsigned char* k2h_get_direct_value(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength);
extern bool k2h_get_str_value(k2h_h handle, const char* pkey, char** ppval);
extern char* k2h_get_str_direct_value(k2h_h handle, const char* pkey);

extern bool k2h_get_value_wp(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength, const char* pass);
extern unsigned char* k2h_get_direct_value_wp(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength, const char* pass);
extern bool k2h_get_str_value_wp(k2h_h handle, const char* pkey, char** ppval, const char* pass);
extern char* k2h_get_str_direct_value_wp(k2h_h handle, const char* pkey, const char* pass);

extern bool k2h_get_value_np(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength);
extern unsigned char* k2h_get_direct_value_np(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength);
extern bool k2h_get_str_value_np(k2h_h handle, const char* pkey, char** ppval);
extern char* k2h_get_str_direct_value_np(k2h_h handle, const char* pkey);

extern bool k2h_get_value_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData);
extern unsigned char* k2h_get_direct_value_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData);
extern bool k2h_get_str_value_ext(k2h_h handle, const char* pkey, char** ppval, k2h_get_trial_callback fp, void* pExtData);
extern char* k2h_get_str_direct_value_ext(k2h_h handle, const char* pkey, k2h_get_trial_callback fp, void* pExtData);

extern bool k2h_get_value_wp_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData, const char* pass);
extern unsigned char* k2h_get_direct_value_wp_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData, const char* pass);
extern bool k2h_get_str_value_wp_ext(k2h_h handle, const char* pkey, char** ppval, k2h_get_trial_callback fp, void* pExtData, const char* pass);
extern char* k2h_get_str_direct_value_wp_ext(k2h_h handle, const char* pkey, k2h_get_trial_callback fp, void* pExtData, const char* pass);

extern bool k2h_get_value_np_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, unsigned char** ppval, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData);
extern unsigned char* k2h_get_direct_value_np_ext(k2h_h handle, const unsigned char* pkey, size_t keylength, size_t* pvallength, k2h_get_trial_callback fp, void* pExtData);
extern bool k2h_get_str_value_np_ext(k2h_h handle, const char* pkey, char** ppval, k2h_get_trial_callback fp, void* pExtData);
extern char* k2h_get_str_direct_value_np_ext(k2h_h handle, const char* pkey, k2h_get_trial_callback fp, void* pExtData);

extern bool k2h_get_subkeys(k2h_h handle, const unsigned char* pkey, size_t keylength, PK2HKEYPCK* ppskeypck, int* pskeypckcnt);
extern PK2HKEYPCK k2h_get_direct_subkeys(k2h_h handle, const unsigned char* pkey, size_t keylength, int* pskeypckcnt);
extern int k2h_get_str_subkeys(k2h_h handle, const char* pkey, char*** ppskeyarray);
extern char** k2h_get_str_direct_subkeys(k2h_h handle, const char* pkey);

extern bool k2h_get_subkeys_np(k2h_h handle, const unsigned char* pkey, size_t keylength, PK2HKEYPCK* ppskeypck, int* pskeypckcnt);
extern PK2HKEYPCK k2h_get_direct_subkeys_np(k2h_h handle, const unsigned char* pkey, size_t keylength, int* pskeypckcnt);
extern int k2h_get_str_subkeys_np(k2h_h handle, const char* pkey, char*** ppskeyarray);
extern char** k2h_get_str_direct_subkeys_np(k2h_h handle, const char* pkey);

extern bool k2h_free_keypack(PK2HKEYPCK pkeys, int keycnt);
extern bool k2h_free_keyarray(char** pkeys);

extern bool k2h_get_attrs(k2h_h handle, const unsigned char* pkey, size_t keylength, PK2HATTRPCK* ppattrspck, int* pattrspckcnt);
extern PK2HATTRPCK k2h_get_direct_attrs(k2h_h handle, const unsigned char* pkey, size_t keylength, int* pattrspckcnt);
extern PK2HATTRPCK k2h_get_str_direct_attrs(k2h_h handle, const char* pkey, int* pattrspckcnt);
extern bool k2h_free_attrpack(PK2HATTRPCK pattrs, int attrcnt);
#
extern bool k2h_set_all(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pval, size_t vallength, const PK2HKEYPCK pskeypck, int skeypckcnt);
extern bool k2h_set_str_all(k2h_h handle, const char* pkey, const char* pval, const char** pskeyarray);
extern bool k2h_set_value(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pval, size_t vallength);
extern bool k2h_set_str_value(k2h_h handle, const char* pkey, const char* pval);

extern bool k2h_set_all_wa(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pval, size_t vallength, const PK2HKEYPCK pskeypck, int skeypckcnt, const char* pass, const time_t* expire);
extern bool k2h_set_str_all_wa(k2h_h handle, const char* pkey, const char* pval, const char** pskeyarray, const char* pass, const time_t* expire);
extern bool k2h_set_value_wa(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pval, size_t vallength, const char* pass, const time_t* expire);
extern bool k2h_set_str_value_wa(k2h_h handle, const char* pkey, const char* pval, const char* pass, const time_t* expire);

extern bool k2h_set_subkeys(k2h_h handle, const unsigned char* pkey, size_t keylength, const PK2HKEYPCK pskeypck, int skeypckcnt);
extern bool k2h_set_str_subkeys(k2h_h handle, const char* pkey, const char** pskeyarray);

extern bool k2h_add_subkey(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* psubkey, size_t skeylength, const unsigned char* pval, size_t vallength);
extern bool k2h_add_str_subkey(k2h_h handle, const char* pkey, const char* psubkey, const char* pval);

extern bool k2h_add_subkey_wa(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* psubkey, size_t skeylength, const unsigned char* pval, size_t vallength, const char* pass, const time_t* expire);
extern bool k2h_add_str_subkey_wa(k2h_h handle, const char* pkey, const char* psubkey, const char* pval, const char* pass, const time_t* expire);

extern bool k2h_add_attr(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pattrkey, size_t attrkeylength, const unsigned char* pattrval, size_t attrvallength);
extern bool k2h_add_str_attr(k2h_h handle, const char* pkey, const char* pattrkey, const char* pattrval);
#
extern bool k2h_remove_all(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern bool k2h_remove_str_all(k2h_h handle, const char* pkey);
extern bool k2h_remove(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern bool k2h_remove_str(k2h_h handle, const char* pkey);
extern bool k2h_remove_subkey(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* psubkey, size_t skeylength);
extern bool k2h_remove_str_subkey(k2h_h handle, const char* pkey, const char* psubkey);
#
extern bool k2h_rename(k2h_h handle, const unsigned char* pkey, size_t keylength, const unsigned char* pnewkey, size_t newkeylength);
extern bool k2h_rename_str(k2h_h handle, const char* pkey, const char* pnewkey);
#
extern bool k2h_get_elements_by_hash(k2h_h handle, const k2h_hash_t starthash, const struct timespec startts, const struct timespec endts, const k2h_hash_t target_hash, const k2h_hash_t target_max_hash, const k2h_hash_t old_hash, const k2h_hash_t old_max_hash, const long target_hash_range, bool is_expire_check, k2h_hash_t* pnexthash, PK2HBIN* ppbindatas, size_t* pdatacnt);
extern bool k2h_set_element_by_binary(k2h_h handle, const PK2HBIN pbindatas, const struct timespec* pts);
#
extern k2h_find_h k2h_find_first(k2h_h handle);
extern k2h_find_h k2h_find_first_subkey(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern k2h_find_h k2h_find_first_str_subkey(k2h_h handle, const char* pkey);
extern k2h_find_h k2h_find_next(k2h_find_h findhandle);
extern bool k2h_find_free(k2h_find_h findhandle);

extern bool k2h_find_get_key(k2h_find_h findhandle, unsigned char** ppkey, size_t* pkeylength);
extern char* k2h_find_get_str_key(k2h_find_h findhandle);
extern bool k2h_find_get_value(k2h_find_h findhandle, unsigned char** ppval, size_t* pvallength);
extern char* k2h_find_get_direct_value(k2h_find_h findhandle);
extern bool k2h_find_get_subkeys(k2h_find_h findhandle, PK2HKEYPCK* ppskeypck, int* pskeypckcnt);
extern PK2HKEYPCK k2h_find_get_direct_subkeys(k2h_find_h findhandle, int* pskeypckcnt);
extern int k2h_find_get_str_subkeys(k2h_find_h findhandle, char*** ppskeyarray);
extern char** k2h_find_get_str_direct_subkeys(k2h_find_h findhandle);
#
extern k2h_da_h k2h_da_handle(k2h_h handle, const unsigned char* pkey, size_t keylength, K2HDAMODE mode);
extern k2h_da_h k2h_da_handle_read(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern k2h_da_h k2h_da_handle_write(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern k2h_da_h k2h_da_handle_rw(k2h_h handle, const unsigned char* pkey, size_t keylength);
extern k2h_da_h k2h_da_str_handle(k2h_h handle, const char* pkey, K2HDAMODE mode);
extern k2h_da_h k2h_da_str_handle_read(k2h_h handle, const char* pkey);
extern k2h_da_h k2h_da_str_handle_write(k2h_h handle, const char* pkey);
extern k2h_da_h k2h_da_str_handle_rw(k2h_h handle, const char* pkey);
extern bool k2h_da_free(k2h_da_h dahandle);

extern ssize_t k2h_da_get_length(k2h_da_h dahandle);

extern ssize_t k2h_da_get_buf_size(k2h_da_h dahandle);
extern bool k2h_da_set_buf_size(k2h_da_h dahandle, size_t bufsize);

extern off_t k2h_da_get_offset(k2h_da_h dahandle, bool is_read);
extern off_t k2h_da_get_read_offset(k2h_da_h dahandle);
extern off_t k2h_da_get_write_offset(k2h_da_h dahandle);
extern bool k2h_da_set_offset(k2h_da_h dahandle, off_t offset, bool is_read);
extern bool k2h_da_set_read_offset(k2h_da_h dahandle, off_t offset);
extern bool k2h_da_set_write_offset(k2h_da_h dahandle, off_t offset);

extern bool k2h_da_get_value(k2h_da_h dahandle, unsigned char** ppval, size_t* pvallength);
extern bool k2h_da_get_value_offset(k2h_da_h dahandle, unsigned char** ppval, size_t* pvallength, off_t offset);
extern bool k2h_da_get_value_to_file(k2h_da_h dahandle, int fd, size_t* pvallength);
extern unsigned char* k2h_da_read(k2h_da_h dahandle, size_t* pvallength);
extern unsigned char* k2h_da_read_offset(k2h_da_h dahandle, size_t* pvallength, off_t offset);
extern char* k2h_da_read_str(k2h_da_h dahandle);

extern bool k2h_da_set_value(k2h_da_h dahandle, const unsigned char* pval, size_t vallength);
extern bool k2h_da_set_value_offset(k2h_da_h dahandle, const unsigned char* pval, size_t vallength, off_t offset);
extern bool k2h_da_set_value_from_file(k2h_da_h dahandle, int fd, size_t* pvallength);
extern bool k2h_da_set_value_str(k2h_da_h dahandle, const char* pval);
#
extern k2h_q_h k2h_q_handle(k2h_h handle, bool is_fifo);
extern k2h_q_h k2h_q_handle_prefix(k2h_h handle, bool is_fifo, const unsigned char* pref, size_t preflen);
extern k2h_q_h k2h_q_handle_str_prefix(k2h_h handle, bool is_fifo, const char* pref);
extern bool k2h_q_free(k2h_q_h qhandle);

extern bool k2h_q_empty(k2h_q_h qhandle);
extern int k2h_q_count(k2h_q_h qhandle);
extern bool k2h_q_read(k2h_q_h qhandle, unsigned char** ppdata, size_t* pdatalen, int pos);
extern bool k2h_q_str_read(k2h_q_h qhandle, char** ppdata, int pos);
extern bool k2h_q_push(k2h_q_h qhandle, const unsigned char* bydata, size_t datalen);
extern bool k2h_q_str_push(k2h_q_h qhandle, const char* pdata);
extern bool k2h_q_pop(k2h_q_h qhandle, unsigned char** ppdata, size_t* pdatalen);
extern bool k2h_q_str_pop(k2h_q_h qhandle, char** ppdata);
extern bool k2h_q_remove(k2h_q_h qhandle, int count);
extern int k2h_q_remove_ext(k2h_q_h qhandle, int count, k2h_q_remove_trial_callback fp, void* pextdata);
extern bool k2h_q_read_wp(k2h_q_h qhandle, unsigned char** ppdata, size_t* pdatalen, int pos, const char* encpass);
extern bool k2h_q_str_read_wp(k2h_q_h qhandle, char** ppdata, int pos, const char* encpass);
extern bool k2h_q_push_wa(k2h_q_h qhandle, const unsigned char* bydata, size_t datalen, const PK2HATTRPCK pattrspck, int attrspckcnt, const char* encpass, const time_t* expire);
extern bool k2h_q_str_push_wa(k2h_q_h qhandle, const char* pdata, const PK2HATTRPCK pattrspck, int attrspckcnt, const char* encpass, const time_t* expire);
extern bool k2h_q_pop_wa(k2h_q_h qhandle, unsigned char** ppdata, size_t* pdatalen, PK2HATTRPCK* ppattrspck, int* pattrspckcnt, const char* encpass);
extern bool k2h_q_str_pop_wa(k2h_q_h qhandle, char** ppdata, PK2HATTRPCK* ppattrspck, int* pattrspckcnt, const char* encpass);
extern bool k2h_q_pop_wp(k2h_q_h qhandle, unsigned char** ppdata, size_t* pdatalen, const char* encpass);
extern bool k2h_q_str_pop_wp(k2h_q_h qhandle, char** ppdata, const char* encpass);
extern bool k2h_q_remove_wp(k2h_q_h qhandle, int count, const char* encpass);
extern int k2h_q_remove_wp_ext(k2h_q_h qhandle, int count, k2h_q_remove_trial_callback fp, void* pextdata, const char* encpass);
extern bool k2h_q_dump(k2h_q_h qhandle, FILE* stream);

extern k2h_keyq_h k2h_keyq_handle(k2h_h handle, bool is_fifo);
extern k2h_keyq_h k2h_keyq_handle_prefix(k2h_h handle, bool is_fifo, const unsigned char* pref, size_t preflen);
extern k2h_keyq_h k2h_keyq_handle_str_prefix(k2h_h handle, bool is_fifo, const char* pref);
extern bool k2h_keyq_free(k2h_keyq_h keyqhandle);

extern bool k2h_keyq_empty(k2h_keyq_h keyqhandle);
extern int k2h_keyq_count(k2h_keyq_h keyqhandle);
extern bool k2h_keyq_read(k2h_keyq_h keyqhandle, unsigned char** ppdata, size_t* pdatalen, int pos);
extern bool k2h_keyq_read_keyval(k2h_keyq_h keyqhandle, unsigned char** ppkey, size_t* pkeylen, unsigned char** ppval, size_t* pvallen, int pos);
extern bool k2h_keyq_str_read(k2h_keyq_h keyqhandle, char** ppdata, int pos);
extern bool k2h_keyq_str_read_keyval(k2h_keyq_h keyqhandle, char** ppkey, char** ppval, int pos);
extern bool k2h_keyq_push(k2h_keyq_h keyqhandle, const unsigned char* bykey, size_t keylen);
extern bool k2h_keyq_push_keyval(k2h_keyq_h keyqhandle, const unsigned char* bykey, size_t keylen, const unsigned char* byval, size_t vallen);
extern bool k2h_keyq_str_push(k2h_keyq_h keyqhandle, const char* pkey);
extern bool k2h_keyq_str_push_keyval(k2h_keyq_h keyqhandle, const char* pkey, const char* pval);
extern bool k2h_keyq_pop(k2h_keyq_h keyqhandle, unsigned char** ppval, size_t* pvallen);
extern bool k2h_keyq_pop_keyval(k2h_keyq_h keyqhandle, unsigned char** ppkey, size_t* pkeylen, unsigned char** ppval, size_t* pvallen);
extern bool k2h_keyq_str_pop(k2h_keyq_h keyqhandle, char** ppval);
extern bool k2h_keyq_str_pop_keyval(k2h_keyq_h keyqhandle, char** ppkey, char** ppval);
extern bool k2h_keyq_remove(k2h_keyq_h keyqhandle, int count);
extern int k2h_keyq_remove_ext(k2h_keyq_h keyqhandle, int count, k2h_q_remove_trial_callback fp, void* pextdata);
extern bool k2h_keyq_read_wp(k2h_keyq_h keyqhandle, unsigned char** ppdata, size_t* pdatalen, int pos, const char* encpass);
extern bool k2h_keyq_read_keyval_wp(k2h_keyq_h keyqhandle, unsigned char** ppkey, size_t* pkeylen, unsigned char** ppval, size_t* pvallen, int pos, const char* encpass);
extern bool k2h_keyq_str_read_wp(k2h_keyq_h keyqhandle, char** ppdata, int pos, const char* encpass);
extern bool k2h_keyq_str_read_keyval_wp(k2h_keyq_h keyqhandle, char** ppkey, char** ppval, int pos, const char* encpass);
extern bool k2h_keyq_push_wa(k2h_keyq_h keyqhandle, const unsigned char* bykey, size_t keylen, const char* encpass, const time_t* expire);
extern bool k2h_keyq_push_keyval_wa(k2h_keyq_h keyqhandle, const unsigned char* bykey, size_t keylen, const unsigned char* byval, size_t vallen, const char* encpass, const time_t* expire);
extern bool k2h_keyq_str_push_wa(k2h_keyq_h keyqhandle, const char* pkey, const char* encpass, const time_t* expire);
extern bool k2h_keyq_str_push_keyval_wa(k2h_keyq_h keyqhandle, const char* pkey, const char* pval, const char* encpass, const time_t* expire);
extern bool k2h_keyq_pop_wp(k2h_keyq_h keyqhandle, unsigned char** ppval, size_t* pvallen, const char* encpass);
extern bool k2h_keyq_pop_keyval_wp(k2h_keyq_h keyqhandle, unsigned char** ppkey, size_t* pkeylen, unsigned char** ppval, size_t* pvallen, const char* encpass);
extern bool k2h_keyq_str_pop_wp(k2h_keyq_h keyqhandle, char** ppval, const char* encpass);
extern bool k2h_keyq_str_pop_keyval_wp(k2h_keyq_h keyqhandle, char** ppkey, char** ppval, const char* encpass);
extern bool k2h_keyq_remove_wp(k2h_keyq_h keyqhandle, int count, const char* encpass);
extern int k2h_keyq_remove_wp_ext(k2h_keyq_h keyqhandle, int count, k2h_q_remove_trial_callback fp, void* pextdata, const char* encpass);
extern bool k2h_keyq_dump(k2h_keyq_h keyqhandle, FILE* stream);
#
extern bool k2h_dump_head(k2h_h handle, FILE* stream);
extern bool k2h_dump_keytable(k2h_h handle, FILE* stream);
extern bool k2h_dump_full_keytable(k2h_h handle, FILE* stream);
extern bool k2h_dump_elementtable(k2h_h handle, FILE* stream);
extern bool k2h_dump_full(k2h_h handle, FILE* stream);
extern bool k2h_print_state(k2h_h handle, FILE* stream);
extern void k2h_print_version(FILE* stream);
extern PK2HSTATE k2h_get_state(k2h_h handle);
#
extern void free_k2hbin(PK2HBIN pk2hbin);
extern void free_k2hbins(PK2HBIN pk2hbin, size_t count);
