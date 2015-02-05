Content-Type: multipart/mixed; boundary="===============8555434232936225283=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Questions about var/lib/ofono/ directories
Date: Thu, 05 Feb 2015 18:28:03 +0100
Message-ID: <54D3A823.8040403@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8555434232936225283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello ofono mailing list,

I'm wondering what ofono puts in the directory "var/lib/ofono/".

On my embedded device, I can see these directories:

  - var/lib/ofono/228014420910471
  - var/lib/ofono/228014420910471-3

The number 228014420910471 is the IMSI of my simcard right ?

In the first one (228014420910471), I can see 3 files called gprs, =

netreg and sms. And there are some configuration in it. It's pretty simple.

In the other directory, there are 4 files (4f20     6f46     6f49 =

version). But I don't understand theirs purposes. Maybe these are SMS =

files ? Why the directory is named <IMSI>-3 ? Other directories with =

another number can be created ?

I'm wondering this because I want to put this directory and files in a =

separated partition of 1.3MB and put my root partition read only. So I'm =

trying to figure out if it's enough, what kind of files ofono will write =

in it, when and the frequency (it's a NOR flash partition and I would =

like to known if it's a good idea). As I understand, ofono uses this =

directory to store SMS also. But, what kind of SMS ? All the SMS I try =

to send ? All the SMS I received ? I began to read the source code but =

maybe you can tell me some hints.

Regards,
Anthony.

-- =

-----------------------------------------
Viallard Anthony    (+41 024 455 24 82)
[ Embedded System | Software Designer ]
-----------------------------------------
   Syscom Instruments SA
   Rue de l'industrie 21
   1450     Sainte-Croix
-----------------------------------------

--===============8555434232936225283==--

