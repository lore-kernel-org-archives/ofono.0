Content-Type: multipart/mixed; boundary="===============6994960554049446868=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Tue, 30 Nov 2010 06:17:10 -0600
Message-ID: <4CF4EB46.4020807@gmail.com>
In-Reply-To: <AANLkTimqaKh56fb1AsKLt-LX7f7-4cWvfUtj2hNGNxXC@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6994960554049446868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 11/30/2010 05:26 AM, Sjur Br=C3=A6ndeland wrote:
> Hi Marcel,
> =

> Marcel Holtmann wrote:
>>>> Or should oFono automatically create a Connection Context?
>>>>
>>>> Furthermore, should oFono automatically proceed and
>>>> set Active=3Dtrue, bind the connection to a network interface
>>>> and set network interface in state UP,
>>>
>>> Definitely not. This would interfere with any other existing IP connect=
ion, say
>>> WiFi.
>>
>> why would bringing an interface up interfere? We are doing this right
>> now. Just the IP assignment is done by ConnMan, but the interface
>> up/down status is controlled by oFono or even BlueZ in case of
>> Bluetooth.
> =

> So does this imply that you think oFono should set Active=3Dtrue and
> and bring up the interface as soon as the Initial PDN  is avilable?
> =

> What about the ConnectionContext, should oFono automatically create a
> new one if needed?

I think it is too early to tell, we need more information about how LTE
works.  Right now I'm not convinced LTE belongs on the ConnectionManager
interface at all.

Regards,
-Denis

--===============6994960554049446868==--

