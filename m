Content-Type: multipart/mixed; boundary="===============5430366691566633665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Write state of SMS assembly to disk and restore on startup.
Date: Tue, 01 Sep 2009 10:09:27 -0500
Message-ID: <9b1cac640909010809g423184bbod704e5de5a27bf86@mail.gmail.com>
In-Reply-To: <1250908843-10576-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5430366691566633665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Aug 21, 2009 at 9:40 PM, Andrzej Zaborowski <
andrew.zaborowski@intel.com> wrote:

> This way we can continue receiving segmented messages over a reset or
> crash.
> ---
>  src/common.c     |   29 +++++++
>  src/common.h     |   10 +++
>  src/sim.c        |   34 --------
>  src/sms.c        |   14 +++-
>  src/smsutil.c    |  237
> +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/smsutil.h    |    3 +-
>  unit/Makefile.am |    6 +-
>  unit/test-sms.c  |    4 +-
>  8 files changed, 293 insertions(+), 44 deletions(-)
>
>
Somehow this patch fell through the cracks completely.  Can you rebase and
resend?


> +
> +int create_dirs(const char *filename, const mode_t mode)
> +{
>

Can we move this part to storage.c instead of common.c to be more consistent
with connman & bluez?


> +
> +#ifdef TEMP_FAILURE_RETRY
> +#define TFR TEMP_FAILURE_RETRY
> +#else
> +#define TFR
> +#endif
> +
> +#include <fcntl.h>
> +
> +int create_dirs(const char *filename, const mode_t mode);
>

storage.c as well.


> +static GSList *sms_assembly_add_fragment_backup(struct sms_assembly
> *assembly,
> +                                       const struct sms *sms, time_t ts,
> +                                       const struct sms_address *addr,
> +                                       guint16 ref, guint8 max, guint8
> seq,
> +                                       gboolean backup);
> +
> +#define SMS_BACKUP_MODE 0600
> +#define SMS_BACKUP_PATH STORAGEDIR "/%s/sms"
> +#define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
> +#define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
> +
> +#define SMS_ADDR_FMT "%21[0-9+*#]"
>

These really belong at the top of the file.  Includes, Defines, globals,
forward declarations, structure definitions in that order.


> +
> +static void sms_assembly_load(struct sms_assembly *assembly,
> +                               const struct dirent *dir)
> +{
> +       for (; len--; free(segments[len])) {
>

Please don't do such evilness.  I don't even understand how this can work.


> +               fd =3D TFR(open(path, O_RDONLY));
> +               g_free(path);
> +
> +               if (fd =3D=3D -1)
> +                       continue;
> +
> +               if (fstat(fd, &segment_stat) !=3D 0) {
> +                       TFR(close(fd));
> +                       continue;
> +               }
> +
> +               r =3D TFR(read(fd, buf, sizeof(buf)));
>

This part should be a utility function in storage.c.  We repeat almost the
same code in sim.c


> +
> +               if (r > 0 && sms_deserialize(buf, &segment, r)) {
> +                       if (sms_assembly_add_fragment_backup(assembly,
> +                                               &segment,
> +                                               segment_stat.st_mtime,
> +                                               &addr, ref, max, seq,
> FALSE)) {
> +                               /* This can't happen */
> +                       }
>

We read it from the backup store and almost immediately overwrite the backup
store?  Seems inefficient.


> +       if (create_dirs(path, SMS_BACKUP_MODE | S_IXUSR)) {
> +               g_free(path);
> +               return FALSE;
> +       }
> +
> +       fd =3D TFR(open(path, O_WRONLY | O_CREAT, SMS_BACKUP_MODE));
> +       if (fd =3D=3D -1) {
> +               g_free(path);
> +               return FALSE;
> +       }
> +
> +       if (TFR(write(fd, buf, len)) < len) {
> +               TFR(close(fd));
> +               unlink(path);
> +               g_free(path);
> +               return FALSE;
> +       }
> +
> +       g_free(path);
> +       TFR(close(fd));
>

Again, sounds like this should be a utility function in storage.c

Regards,
-Denis

--===============5430366691566633665==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQW5kcmV3LDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgQXVnIDIx
LCAyMDA5IGF0IDk6NDAgUE0sIEFuZHJ6ZWogWmFib3Jvd3NraSA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzphbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5hbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJy
PgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBh
ZGRpbmctbGVmdDogMWV4OyI+ClRoaXMgd2F5IHdlIGNhbiBjb250aW51ZSByZWNlaXZpbmcgc2Vn
bWVudGVkIG1lc3NhZ2VzIG92ZXIgYSByZXNldCBvcjxicj4KY3Jhc2guPGJyPgotLS08YnI+CqBz
cmMvY29tbW9uLmMgoCCgIHwgoCAyOSArKysrKysrPGJyPgqgc3JjL2NvbW1vbi5oIKAgoCB8IKAg
MTAgKysrPGJyPgqgc3JjL3NpbS5jIKAgoCCgIKB8IKAgMzQgLS0tLS0tLS08YnI+CqBzcmMvc21z
LmMgoCCgIKAgoHwgoCAxNCArKystPGJyPgqgc3JjL3Ntc3V0aWwuYyCgIKB8IKAyMzcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystPGJyPgqgc3Jj
L3Ntc3V0aWwuaCCgIKB8IKAgoDMgKy08YnI+CqB1bml0L01ha2VmaWxlLmFtIHwgoCCgNiArLTxi
cj4KoHVuaXQvdGVzdC1zbXMuYyCgfCCgIKA0ICstPGJyPgqgOCBmaWxlcyBjaGFuZ2VkLCAyOTMg
aW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPlNvbWVob3cgdGhpcyBwYXRjaCBmZWxsIHRocm91Z2ggdGhlIGNyYWNrcyBjb21wbGV0ZWx5
LqAgQ2FuIHlvdSByZWJhc2UgYW5kIHJlc2VuZD88YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0
LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgoK
CgorPGJyPgoraW50IGNyZWF0ZV9kaXJzKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBjb25zdCBtb2Rl
X3QgbW9kZSk8YnI+Cit7PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj5DYW4gd2UgbW92ZSB0aGlz
IHBhcnQgdG8gc3RvcmFnZS5jIGluc3RlYWQgb2YgY29tbW9uLmMgdG8gYmUgbW9yZSBjb25zaXN0
ZW50IHdpdGggY29ubm1hbiAmYW1wOyBibHVlej88YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0
LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgoK
CgorPGJyPgorI2lmZGVmIFRFTVBfRkFJTFVSRV9SRVRSWTxicj4KKyNkZWZpbmUgVEZSIFRFTVBf
RkFJTFVSRV9SRVRSWTxicj4KKyNlbHNlPGJyPgorI2RlZmluZSBURlI8YnI+CisjZW5kaWY8YnI+
Cis8YnI+CisjaW5jbHVkZSAmbHQ7ZmNudGwuaCZndDs8YnI+Cis8YnI+CitpbnQgY3JlYXRlX2Rp
cnMoY29uc3QgY2hhciAqZmlsZW5hbWUsIGNvbnN0IG1vZGVfdCBtb2RlKTs8YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPnN0b3JhZ2UuYyBhcyB3ZWxsLjxicj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAy
MDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+
CgoKCitzdGF0aWMgR1NMaXN0ICpzbXNfYXNzZW1ibHlfYWRkX2ZyYWdtZW50X2JhY2t1cChzdHJ1
Y3Qgc21zX2Fzc2VtYmx5ICphc3NlbWJseSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCBjb25zdCBzdHJ1Y3Qgc21zICpzbXMsIHRpbWVfdCB0cyw8YnI+CisgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBzdHJ1Y3Qgc21zX2FkZHJl
c3MgKmFkZHIsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZ3Vp
bnQxNiByZWYsIGd1aW50OCBtYXgsIGd1aW50OCBzZXEsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgZ2Jvb2xlYW4gYmFja3VwKTs8YnI+Cis8YnI+CisjZGVmaW5l
IFNNU19CQUNLVVBfTU9ERSAwNjAwPGJyPgorI2RlZmluZSBTTVNfQkFDS1VQX1BBVEggU1RPUkFH
RURJUiAmcXVvdDsvJXMvc21zJnF1b3Q7PGJyPgorI2RlZmluZSBTTVNfQkFDS1VQX1BBVEhfRElS
IFNNU19CQUNLVVBfUEFUSCAmcXVvdDsvJXMtJWktJWkmcXVvdDs8YnI+CisjZGVmaW5lIFNNU19C
QUNLVVBfUEFUSF9GSUxFIFNNU19CQUNLVVBfUEFUSF9ESVIgJnF1b3Q7LyUwM2kmcXVvdDs8YnI+
Cis8YnI+CisjZGVmaW5lIFNNU19BRERSX0ZNVCAmcXVvdDslMjFbMC05KyojXSZxdW90Ozxicj48
L2Jsb2NrcXVvdGU+PGRpdj48YnI+VGhlc2UgcmVhbGx5IGJlbG9uZyBhdCB0aGUgdG9wIG9mIHRo
ZSBmaWxlLqAgSW5jbHVkZXMsIERlZmluZXMsIGdsb2JhbHMsIGZvcndhcmQgZGVjbGFyYXRpb25z
LCBzdHJ1Y3R1cmUgZGVmaW5pdGlvbnMgaW4gdGhhdCBvcmRlci48YnI+oDxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlk
IHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1s
ZWZ0OiAxZXg7Ij4KCis8YnI+CitzdGF0aWMgdm9pZCBzbXNfYXNzZW1ibHlfbG9hZChzdHJ1Y3Qg
c21zX2Fzc2VtYmx5ICphc3NlbWJseSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgY29uc3Qgc3RydWN0IGRpcmVudCAqZGlyKTxicj4KK3s8YnI+CisgoCCgIKAgZm9yICg7IGxl
bi0tOyBmcmVlKHNlZ21lbnRzW2xlbl0pKSB7PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj5QbGVh
c2UgZG9uJiMzOTt0IGRvIHN1Y2ggZXZpbG5lc3MuoCBJIGRvbiYjMzk7dCBldmVuIHVuZGVyc3Rh
bmQgaG93IHRoaXMgY2FuIHdvcmsuPGJyPqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsg
bWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KKyCgIKAgoCCg
IKAgoCCgIGZkID0gVEZSKG9wZW4ocGF0aCwgT19SRE9OTFkpKTs8YnI+CisgoCCgIKAgoCCgIKAg
oCBnX2ZyZWUocGF0aCk7PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgaWYgKGZkID09IC0xKTxi
cj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgY29udGludWU7PGJyPgorPGJyPgorIKAgoCCgIKAg
oCCgIKAgaWYgKGZzdGF0KGZkLCAmYW1wO3NlZ21lbnRfc3RhdCkgIT0gMCkgezxicj4KKyCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgVEZSKGNsb3NlKGZkKSk7PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCBjb250aW51ZTs8YnI+CisgoCCgIKAgoCCgIKAgoCB9PGJyPgorPGJyPgorIKAgoCCgIKAg
oCCgIKAgciA9IFRGUihyZWFkKGZkLCBidWYsIHNpemVvZihidWYpKSk7PGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj5UaGlzIHBhcnQgc2hvdWxkIGJlIGEgdXRpbGl0eSBmdW5jdGlvbiBpbiBzdG9y
YWdlLmMuoCBXZSByZXBlYXQgYWxtb3N0IHRoZSBzYW1lIGNvZGUgaW4gc2ltLmM8YnI+oDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHgg
c29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRk
aW5nLWxlZnQ6IDFleDsiPgoKKzxicj4KKyCgIKAgoCCgIKAgoCCgIGlmIChyICZndDsgMCAmYW1w
OyZhbXA7IHNtc19kZXNlcmlhbGl6ZShidWYsICZhbXA7c2VnbWVudCwgcikpIHs8YnI+CisgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIGlmIChzbXNfYXNzZW1ibHlfYWRkX2ZyYWdtZW50X2JhY2t1cChh
c3NlbWJseSw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgICZhbXA7c2VnbWVudCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIHNlZ21lbnRfc3RhdC5zdF9tdGltZSw8YnI+CisgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZhbXA7YWRkciwgcmVmLCBtYXgsIHNlcSwg
RkFMU0UpKSB7PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIC8qIFRoaXMgY2Fu
JiMzOTt0IGhhcHBlbiAqLzxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgfTxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+V2UgcmVhZCBpdCBmcm9tIHRoZSBiYWNrdXAgc3RvcmUgYW5kIGFsbW9z
dCBpbW1lZGlhdGVseSBvdmVyd3JpdGUgdGhlIGJhY2t1cCBzdG9yZT+gIFNlZW1zIGluZWZmaWNp
ZW50Ljxicj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9y
ZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAw
cHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+CgorIKAgoCCgIGlmIChjcmVhdGVfZGlycyhw
YXRoLCBTTVNfQkFDS1VQX01PREUgfCBTX0lYVVNSKSkgezxicj4KKyCgIKAgoCCgIKAgoCCgIGdf
ZnJlZShwYXRoKTs8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gRkFMU0U7PGJyPgorIKAgoCCg
IH08YnI+Cis8YnI+CisgoCCgIKAgZmQgPSBURlIob3BlbihwYXRoLCBPX1dST05MWSB8IE9fQ1JF
QVQsIFNNU19CQUNLVVBfTU9ERSkpOzxicj4KKyCgIKAgoCBpZiAoZmQgPT0gLTEpIHs8YnI+Cisg
oCCgIKAgoCCgIKAgoCBnX2ZyZWUocGF0aCk7PGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuIEZB
TFNFOzxicj4KKyCgIKAgoCB9PGJyPgorPGJyPgorIKAgoCCgIGlmIChURlIod3JpdGUoZmQsIGJ1
ZiwgbGVuKSkgJmx0OyBsZW4pIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBURlIoY2xvc2UoZmQpKTs8
YnI+CisgoCCgIKAgoCCgIKAgoCB1bmxpbmsocGF0aCk7PGJyPgorIKAgoCCgIKAgoCCgIKAgZ19m
cmVlKHBhdGgpOzxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybiBGQUxTRTs8YnI+CisgoCCgIKAg
fTxicj4KKzxicj4KKyCgIKAgoCBnX2ZyZWUocGF0aCk7PGJyPgorIKAgoCCgIFRGUihjbG9zZShm
ZCkpOzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+QWdhaW4sIHNvdW5kcyBsaWtlIHRoaXMgc2hv
dWxkIGJlIGEgdXRpbGl0eSBmdW5jdGlvbiBpbiBzdG9yYWdlLmM8YnI+PGJyPjwvZGl2PjxkaXY+
UmVnYXJkcyw8YnI+LURlbmlzIDxicj48L2Rpdj48L2Rpdj48YnI+Cg==

--===============5430366691566633665==--

