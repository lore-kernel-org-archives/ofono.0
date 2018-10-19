Content-Type: multipart/mixed; boundary="===============5190224330422308713=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v7 7/7] plugins/gemalto: use Gemalto lte atom
Date: Fri, 19 Oct 2018 07:57:26 +0200
Message-ID: <40602bd7-b3c2-ad03-80ab-e316a59babc1@norrbonn.se>
In-Reply-To: <CAKSBH7HvP8mPbciSZ845RvyqiEPT1i338QYRLX=8mFqSzf3O2Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5190224330422308713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 19/10/18 05:09, Giacinto Cifelli wrote:
> Hi Jonas,
> =

> On Thu, Oct 18, 2018 at 9:41 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> Hi Giacinto,
>>
>> On 18/10/18 20:49, Giacinto Cifelli wrote:
>>> Switch from atmodem to gemaltomodem for the lte atom, in order to
>>> benefit from the correct syntax for the AT commands.
>>> The current models included in the Gemalto plugin only use one type
>>> of authentication syntax, despite the atom supporting the syntax for
>>> all Gemalto modules.
>>> Therefore for now the variable GemaltoAuthType is set to a fixed value,
>>> independent on the model.
>>> ---
>>>    plugins/gemalto.c | 16 +++++++++++++---
>>>    1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
>>> index 5d3c77a9..3ca9f2d6 100644
>>> --- a/plugins/gemalto.c
>>> +++ b/plugins/gemalto.c
>>> @@ -63,6 +63,13 @@ static const char *none_prefix[] =3D { NULL };
>>>    static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
>>>    static const char *sbv_prefix[] =3D { "^SBV:", NULL };
>>>
>>> +enum auth_option {
>>> +     GEMALTO_AUTH_DEFAULTS           =3D 0x00,
>>> +     GEMALTO_AUTH_USE_SGAUTH         =3D 0x01,
>>> +     GEMALTO_AUTH_ORDER_PWD_USR      =3D 0x02,
>>> +     GEMALTO_AUTH_ALW_ALL_PARAMS     =3D 0x04,
>>> +};
>>> +
>>>    struct gemalto_hardware_monitor {
>>>        DBusMessage *msg;
>>>        int32_t temperature;
>>> @@ -609,9 +616,12 @@ static void gemalto_post_sim(struct ofono_modem *m=
odem)
>>>        ofono_call_meter_create(modem, 0, "atmodem", data->app);
>>>        ofono_call_barring_create(modem, 0, "atmodem", data->app);
>>>
>>> -     if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
>>> -             ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
>>> -                                             "atmodem", data->app);
>>> +     if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x)) {
>>> +             ofono_modem_set_integer(modem, "GemaltoAuthType",
>>> +                                             GEMALTO_AUTH_USE_SGAUTH |
>>> +                                             GEMALTO_AUTH_ORDER_PWD_US=
R);
>>> +             ofono_lte_create(modem, 0, "gemaltomodem", data->app);
>>
>> Why not call ofono_modem_get_string(modem, "Model") directly in the LTE
>> atom in order to get the flags?
> =

> Because it is not the atom's job.
> There are other flags planned, and not all will be determined by model.
> Beside, remembering to update each atom for each new modem is error-prone.

It's difficult to provide patch review when part of the job involves =

reading the author's mind to know whither they are going... :)

As things currently stand, the flags are determined _only_ by model and =

are accessed only by gemaltoutil.c.  There's no reason to go from model =

to flags at such a high level.  Put a model_to_flags() function in =

gemaltoutil and keep everything in one place.

/Jonas

--===============5190224330422308713==--

