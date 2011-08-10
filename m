Content-Type: multipart/mixed; boundary="===============7083136526942169858=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Underlying Bluetooth device of a modem
Date: Wed, 10 Aug 2011 17:49:29 +0200
Message-ID: <4E42A889.30802@bmw-carit.de>
In-Reply-To: <4E422907.1090304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7083136526942169858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/10/2011 08:45 AM, Denis Kenzior wrote:
> Hi Mikel,
>
> On 08/10/2011 03:46 AM, Mikel Astiz wrote:
>> Hi all,
>>
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
> Have a look at the Modem.Name property, HFP_HF plugin sets this based on
> the BlueZ Device.Alias property of the remote device.  Which should be
> either the remote device name or the local alias.  This might actually
> be enough for your purposes.
>
>> The purpose of my interest is that, depending on the use-case, the final
>> user would have to choose the modem (or device) manually.
>>
> Depending on the usecase you might require more information, such as the
> bdaddr of the remote device.  In that case you will have to do a bit
> more work, such as defining a new atom that exports the information you
> require.
>
> Regards,
> -Denis

Thanks for your answer.

I replied to Marcel's message before reading yours so we could hopefully =

merge into one message thread.

One specific point to your answer: the device alias is certainly =

available (and in this case would satisfy the use case of =

manually-select-by-alias, so to speak) but that doesn't seem to scale =

well if you would also like to use other criteria (for example, to =

filter some devices depending on their icon, available services, etc.).

Regards,
Mikel


--===============7083136526942169858==--

