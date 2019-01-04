Content-Type: multipart/mixed; boundary="===============2725958661141742471=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] provision: allow duplicate apn's from mbpi
Date: Fri, 04 Jan 2019 15:03:10 +0100
Message-ID: <8970d85f-7b98-e3a3-f152-81a5084fb74a@geanix.com>
In-Reply-To: <f0ac37c3-3fcd-829d-fba2-e82d98ffaeb3@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725958661141742471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/01/2019 19.36, Denis Kenzior wrote:
> On 01/02/2019 05:50 AM, Martin Hundeb=C3=B8ll wrote:
>> Let the user/connection-manager decide what to do with duplicate apn
>> entries instead of bailing out with an error.
>> ---
>> =C2=A0 plugins/provision.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> =

> While seemingly trivial, this actually has a huge impact on user =

> experience.=C2=A0 The problem is that there's no good meta-data for the u=
ser =

> to make the decision as to which service is the one they want.

Yes. The lack of meta-data makes it difficult to make a good decision. =

In the case of the mobile-broadband-provider-info the <name> element =

from the parent provider element would be helpful:

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 433f1b55..69ffea8a 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -56,6 +56,7 @@ struct gsm_data {
         GSList *apns;
         gboolean match_found;
         gboolean allow_duplicates;
+       char *current_name;
  };

  struct cdma_data {
@@ -401,6 +402,9 @@ static void gsm_end(GMarkupParseContext *context, =

const gchar *element_name,
         if (!ap->username || !ap->password)
                 ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;

+       if (!ap->name && gsm->current_name)
+               ap->name =3D g_strdup(gsm->current_name);
+
         if (gsm->allow_duplicates =3D=3D FALSE) {
                 GSList *l;

@@ -503,7 +507,12 @@ static void toplevel_gsm_start(GMarkupParseContext =

*context,
  {
         struct gsm_data *gsm =3D userdata;

-       if (g_str_equal(element_name, "gsm")) {
+       if (g_str_equal(element_name, "name")) {
+               g_free(gsm->current_name);
+               gsm->current_name =3D NULL;
+               g_markup_parse_context_push(context, &text_parser,
+                                               &gsm->current_name);
+       } else if (g_str_equal(element_name, "gsm")) {
                 gsm->match_found =3D FALSE;
                 g_markup_parse_context_push(context, &gsm_parser, gsm);
         } else if (g_str_equal(element_name, "cdma"))
@@ -514,9 +523,16 @@ static void toplevel_gsm_end(GMarkupParseContext =

*context,
                                         const gchar *element_name,
                                         gpointer userdata, GError **error)
  {
+       struct gsm_data *gsm =3D userdata;
+
         if (g_str_equal(element_name, "gsm") ||
-                       g_str_equal(element_name, "cdma"))
+                       g_str_equal(element_name, "cdma") ||
+                       g_str_equal(element_name, "name"))
                 g_markup_parse_context_pop(context);
+       else if (g_str_equal(element_name, "provider")) {
+               g_free(gsm->current_name);
+               gsm->current_name =3D NULL;
+       }
  }

  static const GMarkupParser toplevel_gsm_parser =3D {


> Also, I'm not sure how this impacts connman?=C2=A0 In theory it is suppos=
ed =

> to auto-activate the internet context, and if there are multiple one of =

> these, I'm not sure if it gets confused?

I haven't looked at connman (yet). Couldn't connman create an empty =

internet context if it gets confused? (just like the one ofono creates =

when provision fails.)

> The typical guidance is that if a database contains potential =

> duplicates, then a UI Wizard is needed to guide the user to choose the =

> appropriate one and provision the context that way.

Yes, but wouldn't that require access to the duplicate entries to be =

able to create the wizard?

> Alternatively, provide a provisioning database without conflicts, =

> perhaps specific to the users / operators you're targeting.

That removes the convenience from relying on the =

mobile-broadband-provider-info maintained by upstream.

-- =

Kind regards,
Martin Hundeb=C3=B8ll
Embedded Linux Consultant

+45 61 65 54 61
martin(a)geanix.com

Geanix IVS
https://geanix.com
DK39600706

--===============2725958661141742471==--

