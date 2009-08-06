Content-Type: multipart/mixed; boundary="===============4191938128601582072=="
MIME-Version: 1.0
From: Guo, Young <young.guo@intel.com>
Subject: RE: Patch for Timeout Issue when Importing Phonebook
Date: Thu, 06 Aug 2009 14:59:44 +0800
Message-ID: <C85CEDA13AB1CF4D9D597824A86D2B900578A37213@PDSMSX501.ccr.corp.intel.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001A7604F9F@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4191938128601582072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is this conflict with our design philosophy which is "small and fast"? :)

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Gu, Yang
Sent: Thursday, August 06, 2009 2:47 PM
To: ofono(a)ofono.org
Subject: Patch for Timeout Issue when Importing Phonebook

It often needs a long time (more than default timeout of D-Bus) to retrieve=
 all the entries from phonebook. This patch is to set the timeout to 100 se=
conds so that the operation has enough time to get the result. =


Regards,
-Yang


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Gu, Yang
>Sent: Thursday, August 06, 2009 12:10 AM
>To: ofono(a)ofono.org
>Subject: RE: light test report for ofono v0.2
>
>>4) timeout when reading records at the first time
>Reading records from SIM card requires more time than default timeout of
>D-Bus, so you will get timeout error when you invoke the method via D-Bus
>for the first time. The result will be cached once oFono gets all the reco=
rds,
>thus you may get the records very quickly for the second, third, .., time.
>I will try to update the test case to retrieve the records in an asynchron=
ous
>way.
>
>Regards,
>-Yang
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============4191938128601582072==--

