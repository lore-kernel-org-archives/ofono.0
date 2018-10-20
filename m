Content-Type: multipart/mixed; boundary="===============7197966562416275435=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Sat, 20 Oct 2018 11:18:26 -0500
Message-ID: <ec6a85f6-f138-f3d3-6171-3237a59e2900@gmail.com>
In-Reply-To: <CAKSBH7HtY0TCz3FUTscJUOfXPw9NuYCf0WmXz1xgUfzHUDz+pg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7197966562416275435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>>> +char *gemalto_get_cgdcont_command(struct ofono_modem *modem, guint cid,
>>> +                             enum ofono_gprs_proto proto, const char *=
apn)
>>> +{
>>> +     /*
>>> +      * For future extension: verify if the module supports automatic
>>> +      * context provisioning and if so, also if there is a manual over=
ride
>>> +      * This is an ofono_modem_get_integer property
>>> +      */
>>> +
>>> +     /* for now. Later to consider modules where the LTE attach CID=3D=
3 */
>>> +     if (cid=3D=3D0)
>>> +             cid=3D1;
>>
>> I'm a bit confused why cid=3D=3D0 means cid should be 1... is this becau=
se
>> the AT network-registration atom assumes CID =3D=3D 0 for the default
>> context?  This should probably be fixed at the source, in that case, in
>> atmodem/network-registration.c, with a vendor quirk...???
> =

> the 3GPP 27.007 says that the LTE attach context ID is 0, but actual
> modems use other values.
> For now there are around only models which use CID=3D1, but Gemalto also
> has models with CID=3D3.
> I will have to set another variable for this.
>

I still don't get this explanation.  You have a gemalto specific =

function, which is being passed the CID directly by the caller.  Why is =

there weird logic here to mess with the CID, just have the caller pass =

in the proper CID directly.

Also note that cid 1 and 3 are by default valid CIDs for context =

activations.  So your 'default attach' profile can be overridden by the =

core at any time.  So you may want to address this by setting the cid =

range appropriately.

Regards,
-Denis

--===============7197966562416275435==--

