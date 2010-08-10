Content-Type: multipart/mixed; boundary="===============9180314909971376711=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: RE: [RFC PATCH 5/5] smsutil: save pending status reports to imsi file
Date: Tue, 10 Aug 2010 16:25:42 +0000
Message-ID: <24565F61DC5D5D4BA9D07416A6B5EE6A01C21F@JKLMAIL02.ixonos.local>
In-Reply-To: <FEE7A63B35E92D4F93D1BB82DE254AE5021987@JKLMAIL02.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9180314909971376711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm the guy, who already introduced shortly yesterday to Inaky, and I'm con=
tinuing Pasi Miettinen's fine
work with SMS status-reports.
So, here are some comments (included below) for updating status report-func=
tionality for your earlier comments,
how SR-functionality could be improved.

Br, Petteri

> ________________________________________
> L=C3=A4hett=C3=A4j=C3=A4: ofono-bounces(a)ofono.org [ofono-bounces(a)ofon=
o.org]
> k&#228;ytt&#228;j&#228;n ext Denis Kenzior [denkenz(a)gmail.com] puolesta
> L=C3=A4hetetty: 22. kes=C3=A4kuuta 2010 0:07
> Vastaanottaja: ofono(a)ofono.org
> Aihe: Re: [RFC PATCH 5/5] smsutil: save pending status reports to
>  imsi file
>
> Hi Pasi,
>
> > ---
> >  src/smsutil.c |  205
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files
> changed,
> >  204 insertions(+), 1 deletions(-)
> >
> > diff --git a/src/smsutil.c b/src/smsutil.c
> > index 3db3d28..a30a281 100644
> > --- a/src/smsutil.c
> > +++ b/src/smsutil.c
> > @@ -45,6 +45,10 @@
> >  #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
> >  #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
> >
> > +#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> > +#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
> > +#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
> > +
> >  #define SMS_ADDR_FMT "%24[0-9A-F]"
> >
> >  static GSList *sms_assembly_add_fragment_backup(struct sms_assembly
> >  *assembly, @@ -2625,20 +2629,209 @@ void sms_assembly_expire(struct
> >  sms_assembly *assembly, time_t before) }
> >  }
> >
> > +static void sr_assembly_load_backup(GHashTable *assembly_table,
> > +                                     const char *imsi,
> > +                                     const struct dirent *addr_dir)
> > +{
> > +     char *path;
> > +     struct dirent **ids;
> > +     struct sms_address *addr;
> > +     struct id_table_node *node;
> > +     GHashTable *id_table;
> > +     int len;
> > +     int r;
> > +     unsigned char buf[sizeof(node->mrs) + sizeof(node->total_mrs) +
> > +                     sizeof(node->sent_mrs) + sizeof(node->deliverable=
)];
> > +     char *assembly_table_key;
> > +     unsigned int *id_table_key;
> > +     struct stat segment_stat;
> > +
> > +     if (addr_dir->d_type !=3D DT_DIR)
> > +             return;
> > +
> > +     addr =3D g_new0(struct sms_address, 1);
>
> Why are you mallocing addr here? Seems that this only makes the code
>  more
> complicated.

OK, I will change that, so that mallocs (and freeings) not needed anymore f=
or addr.

>
> > +
> > +     if (sscanf(addr_dir->d_name, "%[0-9]-%i-%i",
> > +                     addr->address, (int *) &addr->number_type,
> > +                     (int *) &addr->numbering_plan) < 3) {
>
> Lets make this consistent with sms assembly, please use SMS_ADDR_FMT.
> You're
> also free to use sms_assembly utility functions if that helps you.
>

OK.

> > +             g_free(addr);
> > +             return;
> > +     }
> > +
> > +     /* Go through different msg_ids. */
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
> > +                                                     addr_dir->d_name);
> > +     len =3D scandir(path, &ids, NULL, versionsort);
> > +
> > +     g_free(path);
> > +
> > +     if (len < 0) {
> > +             g_free(addr);
> > +             return;
> > +     }
> > +
> > +     id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
> > +                                                     g_free, g_free);
> > +
> > +     assembly_table_key =3D g_try_malloc(sizeof(addr->address));
> > +
> > +     if (assembly_table_key =3D=3D NULL) {
> > +             g_free(addr);
> > +             return;
> > +     }
> > +
> > +     g_strlcpy(assembly_table_key, addr->address, sizeof(addr->address=
));
> > +     g_hash_table_insert(assembly_table, assembly_table_key, id_table);
> > +
> > +     while (len--) {
> > +             path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
> > +                             imsi, addr_dir->d_name, ids[len]->d_name);
> > +             r =3D read_file(buf, sizeof(buf), SMS_SR_BACKUP_PATH "/%s=
/%s",
> > +                             imsi, addr_dir->d_name, ids[len]->d_name);
> > +
> > +             if (r < 0) {
> > +                     g_free(path);
> > +                     g_free(ids[len]);
> > +                     continue;
> > +             }
> > +
> > +             r =3D stat(path, &segment_stat);
> > +
> > +             if (r !=3D 0) {
> > +                     g_free(path);
> > +                     g_free(ids[len]);
> > +                     continue;
> > +             }
> > +             /* Gather the data for id_table node */
> > +             node =3D g_new0(struct id_table_node, 1);
> > +             node->to =3D *addr;
>
> Please use memcpy for copying structures.
>

OK.

> > +             node->expiration =3D segment_stat.st_mtime;
> > +             memcpy(node->mrs, buf, sizeof(node->mrs));
> > +             memcpy(&node->total_mrs, buf + sizeof(node->mrs),
> > +                                             sizeof(node->total_mrs));
> > +             memcpy(&node->sent_mrs,
> > +                     buf + sizeof(node->mrs) + sizeof(node->total_mrs),
> > +                     sizeof(node->sent_mrs));
> > +
> > +             memcpy(&node->deliverable, buf + sizeof(node->mrs) +
> > +                     sizeof(node->total_mrs) + sizeof(node->sent_mrs),
> > +                     sizeof(node->deliverable));
> > +             /* Node ready, create key and add them to the table */
> > +             id_table_key =3D g_new0(unsigned int, 1);
> > +             *id_table_key =3D atoi(ids[len]->d_name);
> > +
> > +             g_hash_table_insert(id_table, id_table_key, node);
> > +
> > +             g_free(path);
> > +             g_free(ids[len]);
> > +     }
> > +     g_free(addr);
> > +     g_free(ids);
> > +}
> > +
>
> General comment here is that you're duplicating much of the code that
> inserts
> the information into the data structure.  You can play the same trick as
> sms_assembly which uses a single function to do the heavy lifting,
>  but takes
> an argument whether to store this info on disk.  Obviously during
>  load you
> don't want to re-save this information on disk.  Then your load function
> becomes much smaller and easier to understand.
>

OK. I agree that generally single function for heavy lifting is nicer solut=
ion.
I will implement some general function, which handles adding of new id-tabl=
e (if not already added)
to assembly-table, and storing necessary node-information there. After that=
 I will move some functionality from
sr_assembly_load_backup() to this general function. Also this function can =
be used when sending new sms-text message.
And I will add new parameter for telling, if this function will save data t=
o imsi-file on disk or not.
Existing sms-assembly handles it that way. But, one difference with sms-ass=
embly and status-report logic is, that
sms-assembly naturally stores every messages of concatenated, long SMS-mess=
age to own backup files, but status report
gathers all information belonging to the same long SMS-message (using messa=
ge reference numbers) to the single file.

So Pasi implemented in the loading-phase (sr_assembly_load_backup) storing =
of MR-numbers simply
by copying the whole buffer containing MR's belonging to the single concate=
nated message-node:

1) memcpy(node->mrs, buf, sizeof(node->mrs));

And naturally when sending single message, single MR-bit is set up ('status=
_report_assembly_add_fragment()'):

2) node->mrs[offset] |=3D bit;

So, when now implementing new general function, one solution could be to br=
ing MR-string as parameter
so way (1) could be used in different cases.

Also I have to take care of variable 'sent_mrs', which will be incremented =
in the sms-submit, but not in the loading phase.

> >  struct status_report_assembly *status_report_assembly_new(const char
> >  *imsi) {
> > +     char *path;
> > +     int len;
> > +     struct dirent **addresses;
> >       struct status_report_assembly *ret =3D
> >                               g_new0(struct status_report_assembly, 1);
> >
> >       ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_e=
qual,
> >                               g_free,
> (GDestroyNotify)g_hash_table_destroy);
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
>
> There should be an empty line here
>

OK.

> > +             /* Go through different addresses. Each address can relate
> to
> > +              * 1-n msg_ids. Do not try to load . and .. directories.
> > +              */
> > +             g_free(addresses[0]);
> > +             g_free(addresses[1]);
>
> This really isn't necessary, the '.' and '..' directories will not
>  pass the
> sscanf test above.
>

OK.

> > +
> > +             while (2 < len--) {
> > +                     sr_assembly_load_backup(ret->assembly_table, imsi,
> > +
> addresses[len]);
> > +                     g_free(addresses[len]);
> > +             }
>
> Empty line here please

OK.

>
> > +             g_free(addresses);
> > +     }
>
> And another empty line here.  Please put an empty line after each block
> unless
> it is at the end of the function.

OK.

> >       return ret;
> >  }
> >
> > +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
> > +                                     const struct id_table_node *node,
> > +                                     unsigned int msg_id)
>
> Lets be consistent with how sms assembly works.  E.g. take the main
>  assembly
> object and return void.  Just helps to read the code when it is
>  consistent.
>

OK. Lets give main assembly to this (and corresponding) function(s).
How about return value? For instance existing sms assembly-function 'sms_as=
sembly_add_fragment_backup()'
already returns something else than void.

> > +{
> > +     int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
> > +                     sizeof(node->sent_mrs) + sizeof(node->deliverable=
);
> > +     unsigned char buf[len];
> > +
> > +     if (!imsi)
> > +             return FALSE;
> > +
> > +     memcpy(buf, node->mrs, sizeof(node->mrs));
> > +
> > +     memcpy(buf + sizeof(node->mrs), &node->total_mrs,
> > +                                     sizeof(node->total_mrs));
> > +
> > +     memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs),
> > +                             &node->sent_mrs, sizeof(node->sent_mrs));
> > +
> > +     memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs) +
> > +     sizeof(node->sent_mrs), &node->deliverable,
> sizeof(node->deliverable));
> > +
> > +     /* storagedir/%s/sms_sr/%s-%i-%i/%i */
> > +     if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE,
> imsi,
> > +                     node->to.address, node->to.number_type,
> > +                     node->to.numbering_plan, msg_id) !=3D len)
> > +             return FALSE;
> > +
> > +     return TRUE;
> > +}
> > +
> > +static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
> > +                                     const struct id_table_node *node,
> > +                                     unsigned int msg_id)
>
> Same consistency comment here.  Take main assembly object and return
>  void.
>
> > +{
> > +     char *path;
> > +
> > +     if (!imsi)
> > +             return FALSE;
> > +
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi,
> node->to.address,
> > +                             node->to.number_type,
> node->to.numbering_plan,
> > +                             msg_id);
> > +
> > +     unlink(path);
> > +     g_free(path);
> > +
> > +     path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi,
> node->to.address,
> > +                             node->to.number_type,
> node->to.numbering_plan);
> > +
> > +     /* If the address does not have relating msg_ids anymore, remove =
it
> */
> > +     rmdir(path);
> > +     g_free(path);
> > +
> > +     return TRUE;
> > +}
> > +
> > +static gboolean sr_assembly_update_fragment_backup(const char *imsi,
> > +                                     const struct id_table_node *node,
> > +                                     unsigned int msg_id)
> > +{
> > +     return sr_assembly_remove_fragment_backup(imsi, node, msg_id) &&
> > +                     sr_assembly_add_fragment_backup(imsi, node, msg_i=
d);
> > +}
> > +
>
> Is this function really necessary? write_file overwrites the file,
>  so simply
> using add_fragment_backup seems sufficient.
>

OK. Removal of backup file is not necessary, so I will handle updating of e=
xisting file simple
by overwriting the existing file.

> >  void status_report_assembly_free(struct status_report_assembly *assemb=
ly)
> >  {
> >       g_hash_table_destroy(assembly->assembly_table);
> > @@ -2707,10 +2900,14 @@ gboolean status_report_assembly_report(struct
> >  status_report_assembly *assembly, * not delete the node yet.
> >                */
> >               if (pending) {
> > +                     sr_assembly_update_fragment_backup(assembly->imsi,
> node,
> > +                                                             *msg_id);
>
> It seems to me fragment is the wrong name here.  What about
> 'store_node_backup'?
>
> >                       *msg_delivered =3D FALSE;
> >                       return update_history;
> >               } else {
> >                       *msg_delivered =3D node->deliverable;
> > +                     sr_assembly_remove_fragment_backup(assembly->imsi,
> node,
> > +                                                             *msg_id);
>
> maybe 'remove_node_backup'
>
> >
> >                       g_hash_table_iter_remove(&iter);
> >
> > @@ -2747,6 +2944,7 @@ void status_report_assembly_add_fragment(
> >       unsigned int *id_table_key;
> >
> >       id_table =3D g_hash_table_lookup(assembly->assembly_table,
> to->address);
> > +
> >       /* Create id_table and node */
> >       if (id_table =3D=3D NULL) {
> >               id_table =3D g_hash_table_new_full(g_int_hash, g_int_equa=
l,
> > @@ -2775,6 +2973,9 @@ void status_report_assembly_add_fragment(
> >
> >               g_hash_table_insert(assembly->assembly_table,
> >                                       assembly_table_key, id_table);
> > +
> > +             sr_assembly_add_fragment_backup(assembly->imsi, node,
> msg_id);
> > +
> >               return;
> >       }
> >
> > @@ -2793,12 +2994,14 @@ void status_report_assembly_add_fragment(
> >               *id_table_key =3D msg_id;
> >               g_hash_table_insert(id_table, id_table_key, node);
> >
> > +             sr_assembly_add_fragment_backup(assembly->imsi, node,
> msg_id);
> >               return;
> >       }
> >       /* id_table and node both exists */
> >       node->mrs[offset] |=3D bit;
> >       node->expiration =3D expiration;
> >       node->sent_mrs++;
> > +     sr_assembly_update_fragment_backup(assembly->imsi, node, msg_id);
> >  }
> >
> >  void status_report_assembly_expire(struct status_report_assembly
> >  *assembly,
> >
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>


--===============9180314909971376711==--

