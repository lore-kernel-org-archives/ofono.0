Content-Type: multipart/mixed; boundary="===============3542399314366840276=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] sim800: adding support for SimCom SIM800 modem
Date: Tue, 25 Sep 2018 13:41:23 -0500
Message-ID: <b393cbe2-44b3-b049-732a-b300ac459871@gmail.com>
In-Reply-To: <20180925180824.GA3215@turing>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3542399314366840276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

>>
>> I ran a quick diff between this and sim900 driver and there's really not
>> enough differences to warrant a completely separate plugin.  Can't we ju=
st
>> simply query the model version and act accordingly?
> =

> My opinion is that the sim800 driver is much to be needed as Simcom consi=
ders the sim800 as the new sim900.
> I "fear" that merging the two drivers will end up in a big file having a =
lot of "if...else" for every different feature
> between those two drivers. Whereas having the two separate for some time =
will allow to address the use of sim800's new features
> and support legacy sim900.

It might not be as bad as you think.  Besides, if we determine at some =

future date, that sim800 and sim900 are different enough to warrant =

different drivers, then we have the option of splitting them out into =

separate drivers at that time.

> =

> But as you are the maintainer, I think the decision is yours. Tell me and=
 i'll modify my patches accordingly then preventing too much noisy commits =
:)
> =


My feeling is that we should merge these.  The only difference I see =

right now is a VENDOR flag tweak and an SMS Ready notification handling. =

  These don't amount to much and could be easily handled by the existing =

driver.

Regards,
-Denis

--===============3542399314366840276==--

