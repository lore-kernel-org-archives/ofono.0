Content-Type: multipart/mixed; boundary="===============6002922141389290787=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Re: [RFC PATCH v2 2/4] smsutil: storing/loading sms status report
 over reboot
Date: Wed, 25 Aug 2010 22:56:27 +0300
Message-ID: <201008252256.27310.petteri.tikander@ixonos.com>
In-Reply-To: <4C744D16.50202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6002922141389290787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
and thanks for the comments.
I'm changing the code according to your comments. So I'll change backup-fil=
e =

system to more like flat-system. Earlier messages were stored in address-ba=
sed =

subdirectories, and now, if I understood correctly, those sub-directories =

shouldn't exist anymore. But instead, should be stored in next form in the =

same directory:

sms_addr_1_msg1...
sms_addr_1_msgn
sms_addr_2_msg1...
sms_addr_2_msgn

OK. I already made some implementation, but for some strange reason my test=
ing =

crashes after first sms-message and status-notify (OK, that works, but next =

sms-message sequencies fail):(
I have to investigate tomorrow, what's wrong in my code/environment. At lea=
st =

my modem seems not to work properly all the time, because similar problems =

occur, when I execute 0.26-version.

Br, Petteri

> Hi Petteri,
> =

> On 08/19/2010 12:41 PM, Petteri Tikander wrote:
> > ---
> >  src/smsutil.c |  192
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++-- src/smsutil.h=
 |
> >    2 +-
> >  2 files changed, 188 insertions(+), 6 deletions(-)
> >
> > diff --git a/src/smsutil.c b/src/smsutil.c
> > index c60b8ec..b001a1d 100644
> > --- a/src/smsutil.c
> > +++ b/src/smsutil.c
> > @@ -45,6 +45,10 @@
> >  #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
> >  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
> >
> > +#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> > +#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s"
> > +#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
> > +
> >  #define SMS_ADDR_FMT "%24[0-9A-F]"
> >
> >  static GSList *sms_assembly_add_fragment_backup(struct sms_assembly
> > *assembly, @@ -2413,7 +2417,7 @@ static void
> > sms_assembly_backup_free(struct sms_assembly *assembly, {
> >       char *path;
> >       int seq;
> > -     char straddr[25];
> > +     DECLARE_SMS_ADDR_STR(straddr);
> >
> >       if (!assembly->imsi)
> >               return;
> > @@ -2642,20 +2646,182 @@ void sms_assembly_expire(struct sms_assembly
> > *assembly, time_t before) }
> >  }
> >
> > +static void sr_assembly_load_backup(GHashTable *assembly_table,
> > +                                     const char *imsi,
> > +                                     const struct dirent *addr_dir)
> > +{
> > +     char *path;
> > +     struct dirent **ids;
> > +     struct sms_address addr;
> > +     DECLARE_SMS_ADDR_STR(straddr);
> > +     struct id_table_node *node;
> > +     GHashTable *id_table;
> > +     int len;
> > +     int r;
> > +     char *assembly_table_key;
> > +     unsigned int *id_table_key;
> > +     struct stat segment_stat;
> > +
> > +     if (addr_dir->d_type !=3D DT_DIR)
> > +             return;
> > +
> > +     /* Max of SMS address size is 12 bytes, hex encoded */
> > +     if (sscanf(addr_dir->d_name, SMS_ADDR_FMT, straddr) < 1)
> > +             return;
> > +
> =

> Potential suggestion might be to use a flatter directory structure and
> do something like SMS_ADDR_FMT "-%d"...
> =

> > +     if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
> > +             return;
> > +
> > +     /* Go through different msg_ids. */
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> > +                                                     addr_dir->d_name);
> > +     len =3D scandir(path, &ids, NULL, versionsort);
> > +
> > +     g_free(path);
> > +
> > +     if (len < 0)
> > +             return;
> > +
> > +     id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> > +                                                     g_free, g_free);
> > +
> > +     assembly_table_key =3D g_try_malloc(sizeof(addr.address));
> > +
> > +     if (assembly_table_key =3D=3D NULL)
> > +             return;
> > +
> > +     assembly_table_key =3D g_strdup(sms_address_to_string(&addr));
> =

> g_strdup already mallocs the needed space.  The above g_try_malloc is
> only leaking memory.
> =

> > +     g_hash_table_insert(assembly_table, assembly_table_key, id_table);
> > +
> > +     while (len--) {
> > +             path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
> > +                             imsi, addr_dir->d_name, ids[len]->d_name);
> > +
> =

> You have to make sure to sanitize ids[len]->d_name.  If it is not an
> integer, then it needs to be skipped.  Also watch out for atoi() use
> below, strtol is a much better alternative.
> =

> > +             node =3D g_new0(struct id_table_node, 1);
> > +
> > +             r =3D read_file((unsigned char *) node,
> > +                             sizeof(struct id_table_node),
> > +                             SMS_SR_BACKUP_PATH "/%s/%s",
> > +                             imsi, addr_dir->d_name, ids[len]->d_name);
> > +
> > +             if (r < 0) {
> > +                     g_free(path);
> > +                     g_free(ids[len]);
> > +                     g_free(node);
> > +                     continue;
> > +             }
> > +
> > +             r =3D stat(path, &segment_stat);
> =

> Hah, for sms_assembly we were extra tricky and used the modification
> time stamp on the file system as the received time stamp in the node
> structure.  This works because the file is written at the same time.
> Since we're being lazy and writing out the structure directly this part
> is not needed.
> =

> > +
> > +             if (r !=3D 0) {
> > +                     g_free(path);
> > +                     g_free(ids[len]);
> > +                     g_free(node);
> > +                     continue;
> > +             }
> > +
> > +             /* Node ready, create key and add them to the table */
> > +             id_table_key =3D g_new0(unsigned int, 1);
> > +             *id_table_key =3D atoi(ids[len]->d_name);
> > +
> > +             g_hash_table_insert(id_table, id_table_key, node);
> > +
> > +             g_free(path);
> > +             g_free(ids[len]);
> > +     }
> > +     g_free(ids);
> > +}
> > +
> >  struct status_report_assembly *status_report_assembly_new(const char
> > *imsi) {
> > +     char *path;
> > +     int len;
> > +     struct dirent **addresses;
> >       struct status_report_assembly *ret =3D
> >                               g_new0(struct status_report_assembly, 1);
> >
> >       ret->assembly_table =3D g_hash_table_new_full(g_str_hash,
> > g_str_equal, g_free, (GDestroyNotify)g_hash_table_destroy);
> >
> > -     if (imsi)
> > +     if (imsi) {
> >               ret->imsi =3D imsi;
> >
> > +             /* Restore state from backup */
> > +             path =3D g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
> > +             len =3D scandir(path, &addresses, NULL, alphasort);
> > +
> > +             g_free(path);
> > +
> > +             if (len < 0)
> > +                     return ret;
> > +
> > +             /* Go through different addresses. Each address can relate
> > to +              * 1-n msg_ids.
> > +              */
> =

> Please stick to our multi-line comment guidelines, doc/coding-style.txt
> item M2.  And yes I know the sms_assembly does it this way :)
> =

> > +
> > +             while (len--) {
> > +                     sr_assembly_load_backup(ret->assembly_table, imsi,
> > +                                                            =

> > addresses[len]); +                     g_free(addresses[len]);
> > +             }
> > +
> > +             g_free(addresses);
> > +     }
> > +
> =

> This part looks good otherwise
> =

> >       return ret;
> >  }
> >
> > +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> > +                                     const struct id_table_node *node,
> > +                                     const struct sms_address *addr,
> > +                                     unsigned int msg_id)
> > +{
> > +     int len =3D sizeof(struct id_table_node);
> > +     DECLARE_SMS_ADDR_STR(straddr);
> > +
> > +     if (!imsi)
> > +             return FALSE;
> > +
> > +     if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
> > +             return FALSE;
> > +
> > +     /* storagedir/%s/sms_sr/%s/%i */
> > +     if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
> > +                     SMS_SR_BACKUP_PATH_FILE, imsi,
> > +                     straddr, msg_id) !=3D len)
> > +             return FALSE;
> > +
> > +     return TRUE;
> > +}
> > +
> > +static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
> > +                                     const struct id_table_node *node,
> > +                                     const struct sms_address *addr,
> > +                                     unsigned int msg_id)
> > +{
> > +     char *path;
> > +     DECLARE_SMS_ADDR_STR(straddr);
> > +
> > +     if (!imsi)
> > +             return FALSE;
> > +
> > +     if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
> > +             return FALSE;
> > +
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr,
> > msg_id); +
> > +     unlink(path);
> > +     g_free(path);
> > +
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, straddr);
> > +
> > +     /* If the address does not have relating msg_ids anymore, remove =
it
> > */ +     rmdir(path);
> > +     g_free(path);
> > +
> > +     return TRUE;
> > +}
> > +
> =

> Looks good, but see my earlier comment above about a flatter file
>  structure.
> =

> >  void status_report_assembly_free(struct status_report_assembly
> > *assembly) {
> >       g_hash_table_destroy(assembly->assembly_table);
> > @@ -2698,6 +2864,7 @@ gboolean status_report_assembly_report(struct
> > status_report_assembly *assembly, GHashTableIter iter;
> >       gboolean pending;
> >       int i;
> > +     unsigned int msg_id;
> >
> >       /* We ignore temporary or tempfinal status reports */
> >       if (sr_st_to_delivered(status_report->status_report.st,
> > @@ -2714,7 +2881,6 @@ gboolean status_report_assembly_report(struct
> > status_report_assembly *assembly, g_hash_table_iter_init(&iter,
> > id_table);
> >       while (g_hash_table_iter_next(&iter, &key, &value)) {
> >               node =3D value;
> > -
> =

> This newline is actually needed, please see doc/coding-style.txt item M1
> =

> >               if (node->mrs[offset] & bit)
> >                       break;
> >
> > @@ -2743,14 +2909,29 @@ gboolean status_report_assembly_report(struct
> > status_report_assembly *assembly, }
> >       }
> >
> > -     if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE)
> > +     msg_id =3D *(unsigned int *) key;
> > +
> > +     if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
> > +             /* More status reports expected, and already received
> > +              * reports completed. Update backup file.
> > +              */
> =

> Coding style item M2
> =

> > +             sr_assembly_add_fragment_backup(
> > +                                     assembly->imsi, node,
> > +                                    =

> > &status_report->status_report.raddr, +                                 =
  =

> >  msg_id);
> > +
> >               return FALSE;
> > +     }
> >
> >       if (out_delivered)
> >               *out_delivered =3D node->deliverable;
> >
> >       if (out_id)
> > -             *out_id =3D *((unsigned int *) key);
> > +             *out_id =3D msg_id;
> > +
> > +     sr_assembly_remove_fragment_backup(assembly->imsi, node,
> > +                                    =

> > &status_report->status_report.raddr, +                                 =
  =

> >  msg_id);
> >
> >       g_hash_table_iter_remove(&iter);
> >
> > @@ -2804,6 +2985,7 @@ void status_report_assembly_add_fragment(
> >       node->mrs[offset] |=3D bit;
> >       node->expiration =3D expiration;
> >       node->sent_mrs++;
> > +     sr_assembly_add_fragment_backup(assembly->imsi, node, to, msg_id);
> >  }
> >
> >  void status_report_assembly_expire(struct status_report_assembly
> > *assembly, diff --git a/src/smsutil.h b/src/smsutil.h
> > index eb70b6d..3c6b3ae 100644
> > --- a/src/smsutil.h
> > +++ b/src/smsutil.h
> > @@ -370,7 +370,7 @@ struct id_table_node {
> >       unsigned char total_mrs;
> >       unsigned char sent_mrs;
> >       gboolean deliverable;
> > -};
> > +} __attribute__((packed));
> >
> >  struct status_report_assembly {
> >       const char *imsi;
> =

> Rest looks fine.
> =

> Thanks,
> -Denis
> =



--===============6002922141389290787==--

