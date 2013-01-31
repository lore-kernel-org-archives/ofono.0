Content-Type: multipart/mixed; boundary="===============7058329699707223336=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 2/2] hfp_hf_bluez5: Only register modems for Paired
 devices
Date: Thu, 31 Jan 2013 09:12:59 -0300
Message-ID: <CAKT1EBeRdy5Fw8DzQOuyL06JciwMpga8Q+9xcbKB4f1rt0XiEA@mail.gmail.com>
In-Reply-To: <5109E897.2020800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7058329699707223336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Thu, Jan 31, 2013 at 12:44 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Vinicius,
>
>
> On 01/30/2013 10:24 AM, Claudio Takahasi wrote:
>>
>> From: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
>>
>> When there are many devices around that support the HFP AG profile,
>> we may have a lot of modems that the user will never use.
>> ---
>>   plugins/hfp_hf_bluez5.c | 61
>> +++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 41 insertions(+), 20 deletions(-)
>>
>
> Patch has been applied, however:
>
>
>> -       if (g_str_equal("Alias", name) =3D=3D FALSE)
>> +       if (g_str_equal("Paired", name) =3D=3D TRUE) {
>> +               modem_register_from_proxy(proxy, path);
>>                 return;
>> +       }
>
>
> This part looks suspicious in the case where Paired goes to false.  If Bl=
ueZ
> behaves in a certain way when the device is unpaired then I'd like to see=
 a
> comment here explaining that.

It is possible to unpair a device using the Bluetooth Management
interface, but there isn't D-Bus API to unpair a device. The user
needs to call RemoveDevice(), in this case
hfp_hf_bluez5:proxy_removed() will be called and the modem will be
removed.

Even for MGMT Unpair command the device is being remove, I am not sure
if this is a feature or a bug ;-)

Regards,
Claudio.

--===============7058329699707223336==--

