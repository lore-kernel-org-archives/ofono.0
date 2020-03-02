Content-Type: multipart/mixed; boundary="===============5869024665106284313=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Expose MBPI api over d-bus
Date: Mon, 02 Mar 2020 13:49:04 +0000
Message-ID: <CABPh3UMhmK4vgDGitCROYk2hV-RCjENd6AV_Pfaobq6rS2sr+A@mail.gmail.com>
In-Reply-To: <CABPh3UNsBS8YnW5kWhMHaGkjPN8WFHB7gkXvFtDW9kyMn_FgQQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5869024665106284313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
In regarding to this I found the provision plugin and at line 53 it
uses the mbpi lookup to provision for the default apns but at line 53
it does

apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);

that gives an error in case of multiple providers. -> but if I change
it to gboolean allow_duplicates=3DTRUE
It works and it creates multiple contexts

ap_count =3D g_slist_length(apns);
.....
for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
struct ofono_gprs_provision_data *ap =3D l->data;

memcpy(*settings + i, ap,
sizeof(struct ofono_gprs_provision_data));

g_free(ap);
}

What's the issue in setting mbpi_lookup_apn(mcc, mnc, TRUE, &error); ?????

Regards
Nicola Lunghi

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
diff --git a/plugins/provision.c b/plugins/provision.c
index 99c299eb..aa0b05e4 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -50,7 +50,7 @@ static int provision_get_settings(const char *mcc,
const char *mnc,

        DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);

-       apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
+       apns =3D mbpi_lookup_apn(mcc, mnc, TRUE, &error);
        if (apns =3D=3D NULL) {
                if (error !=3D NULL) {
                        ofono_error("%s", error->message);

On Mon, 2 Mar 2020 at 10:52, nick83ola <nick83ola@gmail.com> wrote:
>
> Dear Ofono developers,
>
> I need to expose the mbpi information over d-bus and possibly
> automatically create profiles based on the information provided in the
> mobile provider information database.
>
> Do you think the right way could be:
> - add a d-bus interface to the mbpi.c plugin
> - or extend the allowed apn plugin to query the mobile provider database?
> - or something else?
>
> Thanks
> Nicola Lunghi
--===============5869024665106284313==--

