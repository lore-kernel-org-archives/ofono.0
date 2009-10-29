Content-Type: multipart/mixed; boundary="===============4156361154547799396=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH 1/2] Added functionality to remove modem from system,
 if needed.
Date: Thu, 29 Oct 2009 15:16:28 +0100
Message-ID: <4AE9A3BC.6080602@gmail.com>
In-Reply-To: <1256824803.5768.42.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4156361154547799396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Marcel Holtmann wrote:
> Hi Ryan,
> =

>> ---
>>  test/enable-modem |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/test/enable-modem b/test/enable-modem
>> index 0f9f604..d44783d 100755
>> --- a/test/enable-modem
>> +++ b/test/enable-modem
>> @@ -1,6 +1,7 @@
>>  #!/usr/bin/python
>>  =

>>  import dbus
>> +import sys
>>  =

>>  bus =3D dbus.SystemBus()
>>  =

>> @@ -14,4 +15,7 @@ path =3D properties["Modems"][0]
>>  modem =3D dbus.Interface(bus.get_object('org.ofono', path),
>>  						'org.ofono.Modem')
>>  =

>> -modem.SetProperty("Powered", dbus.Boolean(1))
>> +if len(sys.argv) > 1 and sys.argv[1] =3D=3D '0' :
>> +    modem.SetProperty("Powered", dbus.Boolean(0))
>> +else :
>> +    modem.SetProperty("Powered", dbus.Boolean(1))
> =

> if you want this, then add a disable-modem script.

Ok. If no one else thinks it may be needed, i won't. In my case, i =

thought it would be helpful to see what happens to the system to remove =

a modem out of the system, ie. power off. I would be nice to be able to =

set a toggle power to the modem, and allow the daemon to be in the =

correct state to recover.

I have tried toggling the power to the modem (has a switch on the board) =

when the daemon was running, and the daemon was not able to return to a =

known state.

Greetings,
Ryan

> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============4156361154547799396==--

