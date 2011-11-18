Content-Type: multipart/mixed; boundary="===============7389687694872640925=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Fri, 18 Nov 2011 09:18:03 -0600
Message-ID: <4EC6772B.8020804@gmail.com>
In-Reply-To: <4EC65B1C.4030504@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7389687694872640925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>> I would also like to see how you're planning to use this information in
>> the core, before reviewing this patch in detail.  Do note that after
>> taking a quick peek at Huawei CDMA manuals and ModemManager, I very much
>> doubt that +CSS is what you want to use in the first place.
> =

> I'm really not familiar with Huawei CDMA AT commands but looking to the
> command interface specification from Huawei and to TIA/EIA/IS-707, I
> can't see other solution than the serving system query to retrieve the
> SID. Also, I don't see any unsolicited result codes which could bring
> such information.
> =

> Note that this AT command seems supported by Huawei cdma modem according
> the first revison of TIA/EIA/IS-707 (here, the band class is not
> supported, neither the PREV field).
> =

> Now, it's true that we would need to retrieve also the NID (as stated in
> TODO), but so far, I don't see how...

I don't really have the answer, but take a peek at ModemManager.  +CSS
is not how it retrieves SID in the most common case.  In fact it doesn't
even do it via AT commands.  If that's the case, then you might want to
rethink this implementation completely.

Regards,
-Denis

--===============7389687694872640925==--

