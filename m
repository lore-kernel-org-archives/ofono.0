Content-Type: multipart/mixed; boundary="===============5512735427618390374=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Underlying Bluetooth device of a modem
Date: Wed, 10 Aug 2011 17:39:37 +0200
Message-ID: <4E42A639.3060707@bmw-carit.de>
In-Reply-To: <1312983556.3373.112.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5512735427618390374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 08/10/2011 03:39 PM, Marcel Holtmann wrote:
> Hi Mikel,
>
>> I am trying to set up a simple HFP demonstrator using
>> BlueZ+oFono+PulseAudio, with a dbus client that coordinates the three of
>> them. Being a simple prototype, the goal is to see how they behave and
>> analyze how well it would all scale.
>>
>> The first question that arises is quite simple. In a multi-phone
>> scenario (all of them connected to our PC using Bluetooth HFP), oFono
>> properly lists all the phones as available modems. I would like to know
>> whether these modems can be associated to their underlying bluetooth
>> device (mac address, bluez device dbus path, or whatever). I have been
>> looking on the available modem properties but this seems not to be
>> present. Could somebody confirm this or otherwise explain how it can be
>> done?
>>
>> The purpose of my interest is that, depending on the use-case, the final
>> user would have to choose the modem (or device) manually.
> you would need to be a bit more specific on what the actual use case
> entails here. How would selection work and how the user is involved in
> it. Depending on that, things should be done differently.
>
> So besides that, some simple pieces that come to mind quickly are to
> create a HFP devinfo atom driver that just exports the BD_ADDR as serial
> number.

Thanks for your quick answer.

Regarding the use case, the most obvious situation would be that the =

user would choose the device based on its Bluetooth alias, there could =

be other alternatives too. In any case, your answer seems to confirm =

that oFono currently does not expose this information, right?

Regarding your proposal of the devinfo driver, I will give it a try. I'm =

not actually familiar with the source code but that doesn't sound too =

difficult.

Another idea I was thinking about is to add a specific d-bus interface =

for these modems. Similar approaches could be followed by other modem =

types (if strictly necessary and modem-type specific). Would that make =

sense to you? I guess it's not desirable to have interfaces with one =

single method, but still it might be better than adding functionality to =

existing interfaces (for example by adding an optional property to =

org.ofono.Modem).

Best regards,

Mikel


--===============5512735427618390374==--

