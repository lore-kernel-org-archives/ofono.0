Content-Type: multipart/mixed; boundary="===============4439310338773609036=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] provision: allow duplicate apn's from mbpi
Date: Fri, 04 Jan 2019 15:03:04 -0600
Message-ID: <c13139cb-d5c8-fecd-cd41-f1e165742250@gmail.com>
In-Reply-To: <8970d85f-7b98-e3a3-f152-81a5084fb74a@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4439310338773609036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/04/2019 08:03 AM, Martin Hundeb=C3=B8ll wrote:
> Hi Denis,
> =

> On 02/01/2019 19.36, Denis Kenzior wrote:
>> On 01/02/2019 05:50 AM, Martin Hundeb=C3=B8ll wrote:
>>> Let the user/connection-manager decide what to do with duplicate apn
>>> entries instead of bailing out with an error.
>>> ---
>>> =C2=A0 plugins/provision.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> While seemingly trivial, this actually has a huge impact on user =

>> experience.=C2=A0 The problem is that there's no good meta-data for the =

>> user to make the decision as to which service is the one they want.
> =

> Yes. The lack of meta-data makes it difficult to make a good decision. =

> In the case of the mobile-broadband-provider-info the <name> element =

> from the parent provider element would be helpful:
> =

> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index 433f1b55..69ffea8a 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -56,6 +56,7 @@ struct gsm_data {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSList *apns;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gboolean match_found;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gboolean allow_duplicates;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *current_name;
>  =C2=A0};
> =

>  =C2=A0struct cdma_data {
> @@ -401,6 +402,9 @@ static void gsm_end(GMarkupParseContext *context, =

> const gchar *element_name,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ap->username || !ap->pas=
sword)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> =

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ap->name && gsm->current_name)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ap->name =3D g_strdup(gsm->current_name);
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gsm->allow_duplicates =3D=
=3D FALSE) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 GSList *l;
> =

> @@ -503,7 +507,12 @@ static void toplevel_gsm_start(GMarkupParseContext =

> *context,
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gsm_data *gsm =3D user=
data;
> =

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_str_equal(element_name, "gsm"=
)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_str_equal(element_name, "name=
")) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 g_free(gsm->current_name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gsm->current_name =3D NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 g_markup_parse_context_push(context, &text_parser,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gsm->current_name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (g_str_equal(element_name=
, "gsm")) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gsm->match_found =3D FALSE;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 g_markup_parse_context_push(context, &gsm_parser, gsm);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (g_str_equal(elemen=
t_name, "cdma"))
> @@ -514,9 +523,16 @@ static void toplevel_gsm_end(GMarkupParseContext =

> *context,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const gchar *element_name,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gpointer userdata, GError **error)
>  =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gsm_data *gsm =3D userdata;
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_str_equal(element_name,=
 "gsm") ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_str_equal(el=
ement_name, "cdma"))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_str_equal(el=
ement_name, "cdma") ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_str_equal(el=
ement_name, "name"))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 g_markup_parse_context_pop(context);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (g_str_equal(element_name, =
"provider")) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 g_free(gsm->current_name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gsm->current_name =3D NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0}
> =

>  =C2=A0static const GMarkupParser toplevel_gsm_parser =3D {
> =


I don't really mind taking a patch like this since it at least gives =

some basic name to the context if the <name> tag is missing inside the =

<apn> tag.  But...  I don't see how this helps you at all?  If you have =

duplicates, then you just get both contexts named the same way.  Maybe =

you're lucky and one context has a name and the other can use the =

provider name.  But still, not great user experience.

Also note that mbpi doesn't really make it clear whether any of these =

names are localized or need to be translated.  oFono doesn't do =

translations, any printable strings are assumed to be localized by the SIM.

I guess you can tell that I'm no fan of mbpi.  If you're doing something =

serious, you're much better off looking into using something else.

> =

>> Also, I'm not sure how this impacts connman?=C2=A0 In theory it is suppo=
sed =

>> to auto-activate the internet context, and if there are multiple one =

>> of these, I'm not sure if it gets confused?
> =

> I haven't looked at connman (yet). Couldn't connman create an empty =

> internet context if it gets confused? (just like the one ofono creates =

> when provision fails.)

I don't think so?  But this is a conversation you need to have with the =

ConnMan folks.

> =

>> The typical guidance is that if a database contains potential =

>> duplicates, then a UI Wizard is needed to guide the user to choose the =

>> appropriate one and provision the context that way.
> =

> Yes, but wouldn't that require access to the duplicate entries to be =

> able to create the wizard?

No, just have the wizard parse mbpi directly.

> =

>> Alternatively, provide a provisioning database without conflicts, =

>> perhaps specific to the users / operators you're targeting.
> =

> That removes the convenience from relying on the =

> mobile-broadband-provider-info maintained by upstream.
> =


Not a big loss in my opinion ;)

Regards,
-Denis

--===============4439310338773609036==--

