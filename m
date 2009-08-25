Content-Type: multipart/mixed; boundary="===============0133059518756810552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Expose service dialling numbers stored on SIM through SimManager.
Date: Tue, 25 Aug 2009 11:41:13 -0500
Message-ID: <9b1cac640908250941p616e9906vfcef484891d23787@mail.gmail.com>
In-Reply-To: <1250712567-9169-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0133059518756810552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Aug 19, 2009 at 3:09 PM, Andrzej Zaborowski <
andrew.zaborowski@intel.com> wrote:

> ---
> The ServiceDiallingNumbers property now returns a list of strings (alpha
> identifiers interleaved with dialling numbers) and this is a little hacky
> but returning a dictionary would make the interface more hassle to use so
> I'm not sure what's better.


Please re-base and resubmit this patch, it does not apply cleanly after the
latest round of changes.

Also, lets return a dictionary.  Applications already need to parse
GetProperties, which is a dictionary of strings to variants, so
string->string shouldn't be a big deal.


> +
> +       if (sim_adn_parse(data, record_length, &ph, &alpha) =3D=3D TRUE &&
> alpha) {
> +               struct service_number *sdn;
> +
> +               sdn =3D g_new(struct service_number, 1);
> +               sdn->id =3D alpha;


Lets make sure that the id is non-empty.  If it is empty, we should we use
the phone number as the id unless you can think of something better.


>
> +               memcpy(&sdn->ph, &ph, sizeof(struct ofono_phone_number));
> +
> +               sim->service_numbers =3D
> +                       g_slist_prepend(sim->service_numbers, sdn);


Do we want to check for id uniqueness here?


>
> +       }
> +
> +       if (record !=3D total)
> +               return;
> +
> +check:
> +       /* All records retrieved */
> +       if (sim->service_numbers) {
> +               sim->service_numbers =3D
> g_slist_reverse(sim->service_numbers);
> +
> +               service_numbers =3D
> get_service_numbers(sim->service_numbers);
> +
> +               ofono_dbus_signal_array_property_changed(conn, modem->pat=
h,
> +                                               SIM_MANAGER_INTERFACE,
> +                                               "ServiceDiallingNumbers",
> +                                               DBUS_TYPE_STRING,
> +                                               &service_numbers);
> +               g_strfreev(service_numbers);
> +       }
>  }
>
> -static void sim_mnc_length_update(struct ofono_modem *modem)
> +static void sim_own_numbers_update(struct ofono_modem *modem)
>  {
> -       ofono_sim_read(modem, SIM_EFAD_FILEID,
> -                       sim_ad_read_cb, modem->sim_manager);
> +       ofono_sim_read(modem, SIM_EFMSISDN_FILEID,
> +                       sim_msisdn_read_cb, modem->sim_manager);
>  }
>
>  static void sim_ready(struct ofono_modem *modem)
>  {
>        sim_own_numbers_update(modem);
> -       sim_mnc_length_update(modem);
> +
> +       ofono_sim_read(modem, SIM_EFAD_FILEID,
> +                       sim_ad_read_cb, modem->sim_manager);
> +       ofono_sim_read(modem, SIM_EFSDN_FILEID,
> +                       sim_sdn_read_cb, modem->sim_manager);
>  }
>
>  static void sim_imsi_cb(const struct ofono_error *error, const char *ims=
i,
> diff --git a/src/simutil.h b/src/simutil.h
> index dccbe7b..de3e55e 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -22,6 +22,7 @@
>  enum sim_fileid {
>        SIM_EFMSISDN_FILEID =3D 0x6f40,
>        SIM_EFSPN_FILEID =3D 0x6f46,
> +       SIM_EFSDN_FILEID =3D 0x6f49,
>        SIM_EFAD_FILEID =3D 0x6fad,
>        SIM_EFPNN_FILEID =3D 0x6fc5,
>        SIM_EFOPL_FILEID =3D 0x6fc6,
> --
> 1.6.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============0133059518756810552==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQW5kcmV3LDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFdlZCwgQXVnIDE5
LCAyMDA5IGF0IDM6MDkgUE0sIEFuZHJ6ZWogWmFib3Jvd3NraSA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzphbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5hbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJy
Pgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KLS0tPGJyPgpU
aGUgU2VydmljZURpYWxsaW5nTnVtYmVycyBwcm9wZXJ0eSBub3cgcmV0dXJucyBhIGxpc3Qgb2Yg
c3RyaW5ncyAoYWxwaGE8YnI+CmlkZW50aWZpZXJzIGludGVybGVhdmVkIHdpdGggZGlhbGxpbmcg
bnVtYmVycykgYW5kIHRoaXMgaXMgYSBsaXR0bGUgaGFja3k8YnI+CmJ1dCByZXR1cm5pbmcgYSBk
aWN0aW9uYXJ5IHdvdWxkIG1ha2UgdGhlIGludGVyZmFjZSBtb3JlIGhhc3NsZSB0byB1c2Ugc288
YnI+CkkmIzM5O20gbm90IHN1cmUgd2hhdCYjMzk7cyBiZXR0ZXIuPC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+UGxlYXNlIHJlLWJhc2UgYW5kIHJlc3VibWl0IHRoaXMgcGF0Y2gsIGl0
IGRvZXMgbm90IGFwcGx5IGNsZWFubHkgYWZ0ZXIgdGhlIGxhdGVzdCByb3VuZCBvZiBjaGFuZ2Vz
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QWxzbywgbGV0cyByZXR1cm4gYSBkaWN0aW9uYXJ5
LiCgQXBwbGljYXRpb25zIGFscmVhZHkgbmVlZCB0byBwYXJzZSBHZXRQcm9wZXJ0aWVzLCB3aGlj
aCBpcyBhIGRpY3Rpb25hcnkgb2Ygc3RyaW5ncyB0byB2YXJpYW50cywgc28gc3RyaW5nLSZndDtz
dHJpbmcgc2hvdWxkbiYjMzk7dCBiZSBhIGJpZyBkZWFsLjwvZGl2PgoKPGRpdj6gPC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Kzxicj4KKyCgIKAgoCBp
ZiAoc2ltX2Fkbl9wYXJzZShkYXRhLCByZWNvcmRfbGVuZ3RoLCAmYW1wO3BoLCAmYW1wO2FscGhh
KSA9PSBUUlVFICZhbXA7JmFtcDsgYWxwaGEpIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBzdHJ1Y3Qg
c2VydmljZV9udW1iZXIgKnNkbjs8YnI+Cis8YnI+CisgoCCgIKAgoCCgIKAgoCBzZG4gPSBnX25l
dyhzdHJ1Y3Qgc2VydmljZV9udW1iZXIsIDEpOzxicj4KKyCgIKAgoCCgIKAgoCCgIHNkbi0mZ3Q7
aWQgPSBhbHBoYTs8L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5MZXRzIG1ha2Ugc3Vy
ZSB0aGF0IHRoZSBpZCBpcyBub24tZW1wdHkuIKBJZiBpdCBpcyBlbXB0eSwgd2Ugc2hvdWxkIHdl
IHVzZSB0aGUgcGhvbmUgbnVtYmVyIGFzIHRoZSBpZCB1bmxlc3MgeW91IGNhbiB0aGluayBvZiBz
b21ldGhpbmcgYmV0dGVyLjwvZGl2PjxkaXY+CgqgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGJyPgorIKAgoCCgIKAgoCCgIKAgbWVtY3B5KCZhbXA7
c2RuLSZndDtwaCwgJmFtcDtwaCwgc2l6ZW9mKHN0cnVjdCBvZm9ub19waG9uZV9udW1iZXIpKTs8
YnI+Cis8YnI+CisgoCCgIKAgoCCgIKAgoCBzaW0tJmd0O3NlcnZpY2VfbnVtYmVycyA9PGJyPgor
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBnX3NsaXN0X3ByZXBlbmQoc2ltLSZndDtzZXJ2aWNlX251
bWJlcnMsIHNkbik7PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+RG8gd2Ugd2FudCB0
byBjaGVjayBmb3IgaWQgdW5pcXVlbmVzcyBoZXJlPzwvZGl2PjxkaXY+oDwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgoKPGJyPgorIKAgoCCgIH08YnI+
Cis8YnI+CisgoCCgIKAgaWYgKHJlY29yZCAhPSB0b3RhbCk8YnI+CisgoCCgIKAgoCCgIKAgoCBy
ZXR1cm47PGJyPgorPGJyPgorY2hlY2s6PGJyPgorIKAgoCCgIC8qIEFsbCByZWNvcmRzIHJldHJp
ZXZlZCAqLzxicj4KKyCgIKAgoCBpZiAoc2ltLSZndDtzZXJ2aWNlX251bWJlcnMpIHs8YnI+Cisg
oCCgIKAgoCCgIKAgoCBzaW0tJmd0O3NlcnZpY2VfbnVtYmVycyA9IGdfc2xpc3RfcmV2ZXJzZShz
aW0tJmd0O3NlcnZpY2VfbnVtYmVycyk7PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgc2Vydmlj
ZV9udW1iZXJzID0gZ2V0X3NlcnZpY2VfbnVtYmVycyhzaW0tJmd0O3NlcnZpY2VfbnVtYmVycyk7
PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgb2Zvbm9fZGJ1c19zaWduYWxfYXJyYXlfcHJvcGVy
dHlfY2hhbmdlZChjb25uLCBtb2RlbS0mZ3Q7cGF0aCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIFNJTV9NQU5BR0VSX0lOVEVSRkFDRSw8YnI+Cisg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90O1NlcnZp
Y2VEaWFsbGluZ051bWJlcnMmcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCBEQlVTX1RZUEVfU1RSSU5HLDxicj4KKyCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgJmFtcDtzZXJ2aWNlX251bWJlcnMpOzxi
cj4KKyCgIKAgoCCgIKAgoCCgIGdfc3RyZnJlZXYoc2VydmljZV9udW1iZXJzKTs8YnI+CisgoCCg
IKAgfTxicj4KoH08YnI+Cjxicj4KLXN0YXRpYyB2b2lkIHNpbV9tbmNfbGVuZ3RoX3VwZGF0ZShz
dHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KK3N0YXRpYyB2b2lkIHNpbV9vd25fbnVtYmVy
c191cGRhdGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+CqB7PGJyPgotIKAgoCCgIG9m
b25vX3NpbV9yZWFkKG1vZGVtLCBTSU1fRUZBRF9GSUxFSUQsPGJyPgotIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCBzaW1fYWRfcmVhZF9jYiwgbW9kZW0tJmd0O3NpbV9tYW5hZ2VyKTs8YnI+CisgoCCg
IKAgb2Zvbm9fc2ltX3JlYWQobW9kZW0sIFNJTV9FRk1TSVNETl9GSUxFSUQsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCBzaW1fbXNpc2RuX3JlYWRfY2IsIG1vZGVtLSZndDtzaW1fbWFuYWdl
cik7PGJyPgqgfTxicj4KPGJyPgqgc3RhdGljIHZvaWQgc2ltX3JlYWR5KHN0cnVjdCBvZm9ub19t
b2RlbSAqbW9kZW0pPGJyPgqgezxicj4KIKAgoCCgIKBzaW1fb3duX251bWJlcnNfdXBkYXRlKG1v
ZGVtKTs8YnI+Ci0goCCgIKAgc2ltX21uY19sZW5ndGhfdXBkYXRlKG1vZGVtKTs8YnI+Cis8YnI+
CisgoCCgIKAgb2Zvbm9fc2ltX3JlYWQobW9kZW0sIFNJTV9FRkFEX0ZJTEVJRCw8YnI+CisgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIHNpbV9hZF9yZWFkX2NiLCBtb2RlbS0mZ3Q7c2ltX21hbmFnZXIp
Ozxicj4KKyCgIKAgoCBvZm9ub19zaW1fcmVhZChtb2RlbSwgU0lNX0VGU0ROX0ZJTEVJRCw8YnI+
CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHNpbV9zZG5fcmVhZF9jYiwgbW9kZW0tJmd0O3NpbV9t
YW5hZ2VyKTs8YnI+CqB9PGJyPgo8YnI+CqBzdGF0aWMgdm9pZCBzaW1faW1zaV9jYihjb25zdCBz
dHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLCBjb25zdCBjaGFyICppbXNpLDxicj4KZGlmZiAtLWdp
dCBhL3NyYy9zaW11dGlsLmggYi9zcmMvc2ltdXRpbC5oPGJyPgppbmRleCBkY2NiZTdiLi5kZTNl
NTVlIDEwMDY0NDxicj4KLS0tIGEvc3JjL3NpbXV0aWwuaDxicj4KKysrIGIvc3JjL3NpbXV0aWwu
aDxicj4KQEAgLTIyLDYgKzIyLDcgQEA8YnI+CqBlbnVtIHNpbV9maWxlaWQgezxicj4KIKAgoCCg
IKBTSU1fRUZNU0lTRE5fRklMRUlEID0gMHg2ZjQwLDxicj4KIKAgoCCgIKBTSU1fRUZTUE5fRklM
RUlEID0gMHg2ZjQ2LDxicj4KKyCgIKAgoCBTSU1fRUZTRE5fRklMRUlEID0gMHg2ZjQ5LDxicj4K
IKAgoCCgIKBTSU1fRUZBRF9GSUxFSUQgPSAweDZmYWQsPGJyPgogoCCgIKAgoFNJTV9FRlBOTl9G
SUxFSUQgPSAweDZmYzUsPGJyPgogoCCgIKAgoFNJTV9FRk9QTF9GSUxFSUQgPSAweDZmYzYsPGJy
Pgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LS08YnI+CjEuNi4xPGJyPgo8YnI+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxp
c3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5v
Zm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xp
c3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0
aW5mby9vZm9ubzwvYT48YnI+CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============0133059518756810552==--

