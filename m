Received: from mail.expatria.ca (mail.expatria.ca [144.217.207.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84F37DE84
	for <ofono@lists.linux.dev>; Thu, 12 Mar 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.207.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347945; cv=none; b=ni47CGsafnnWMbWcW8ywEDTsgS1CzEwrSfjWiPuHNmc3/8i+KW0zxqAW/2T+lGuB9ytq3LeSanXsKoA6xfYt8HcVmGUrXozrwT9bMSh97kf+OfLaB5wLeYObhk6/eNZJeY7vWKkMRUHHG4qVJuvXZsaoq5Siw55cCJURHDmDMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347945; c=relaxed/simple;
	bh=0+DY9YWtqgtZCkbP13B2a7p7Z5Ot+eArGtLZ9lEj11M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Q3v2HQgpafgqSYbKZIj5eGAY55mMzOmr95Eoy1mJ476whB0VfEb+9FA6D67FB1Gp8JFCkRdeukD9o+b+BA5fhOQuygW+fkHpyvl8YHGCsSecOyI0Z6bR+IvCmfq9VypIrYcP5uj5RISNR+Ta+k8y1sxBPqCwiSYjoseaknCdm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=expatria.ca; spf=pass smtp.mailfrom=expatria.ca; dkim=pass (2048-bit key) header.d=expatria.ca header.i=@expatria.ca header.b=CZTfOngJ; arc=none smtp.client-ip=144.217.207.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=expatria.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=expatria.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=expatria.ca header.i=@expatria.ca header.b="CZTfOngJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=expatria.ca;
	s=default; t=1773347559;
	bh=0+DY9YWtqgtZCkbP13B2a7p7Z5Ot+eArGtLZ9lEj11M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CZTfOngJcEzM9eAjpRizvMPfCfM9M5Q3gxyAqavx7HmpXxsvT1ckBJf2GfA4KlKln
	 z1sfLsHJmzCkXJZaJxcaXc5EsJCYEsCQCpGdEVaYjb50CxIFwF6bgUvImFYUKTkZRS
	 nP4intFtlX3cNQHJtd5jZwxcYhlrSiAACk2JTtdIKKh+dOFMABWBZPIepjOJht7m96
	 rMrOYcETDv9c8ubKKeiv8xd6tx3/tiV7FdicVXbZNHKdMEL80BqlrUKCE7WIIWmdIt
	 38hDsHzbd9XItd4hwZLpsmRcRlWaKItt8Lj38xUvu4edpPPU6lW/0KPnzIW3G4rGgl
	 srTQXFdfEVz2A==
Received: from [10.89.51.52] (d154-20-248-80.bchsia.telus.net [154.20.248.80])
	by mail.expatria.ca (Postfix) with ESMTPSA id 69294124C1;
	Thu, 12 Mar 2026 20:32:38 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------XRNfIUndevMGWEP8jBBh8lW0"
Message-ID: <9571cabe-0c3d-43b8-be30-32ce44e6343c@expatria.ca>
Date: Thu, 12 Mar 2026 13:32:37 -0700
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ZDI-CAN-29089: New Vulnerability Report
To: Sicelo <absicsz@gmail.com>,
 "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: Willy Tarreau <w@1wt.eu>, "ofono@lists.linux.dev"
 <ofono@lists.linux.dev>, "secalert@redhat.com" <secalert@redhat.com>,
 ivo.g.dimitrov.75@gmail.com, maemo-leste@lists.dyne.org
References: <BYAPR01MB3830BD5C9755FDDBA5ADE0FC8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB38303CF32A86888EBE5918DA8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB3830E1E9E11FC8716A722A588062A@BYAPR01MB3830.prod.exchangelabs.com>
 <aYtkc7oTpBivYUZ1@1wt.eu>
 <BYAPR01MB38300A127FB5267EA5A6846E8044A@BYAPR01MB3830.prod.exchangelabs.com>
 <abMecbIIvAhibdPv@tp440p.steeds.sam>
Content-Language: en-US
From: Morgan Hughes <morgan@expatria.ca>
In-Reply-To: <abMecbIIvAhibdPv@tp440p.steeds.sam>

This is a multi-part message in MIME format.
--------------XRNfIUndevMGWEP8jBBh8lW0
Content-Type: multipart/alternative;
 boundary="------------uOfmbM0by1jXN1c4vmLhn9LF"

--------------uOfmbM0by1jXN1c4vmLhn9LF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-03-12 13:13, Sicelo wrote:
> Community members will work on these. As with any other open-source
> projects, patches welcome.

This looks a lot like a problem I encountered on a buggy modem in October and submitted a 
patch for.  I've re-attached the patch here, perhaps it was missed because I didn't submit 
it using git?

Morgan Hughes


>
>
>
> On Thu, Mar 12, 2026 at 07:13:20PM +0000,zdi-disclosures@trendmicro.com wrote:
>> Hello Willy,
>>
>> Noted thank you!
>>
>> Any updates on this issue?
>>
>> Thanks,
>> ZDI
>>
>> -----Original Message-----
>> From: Willy Tarreau<w@1wt.eu>
>> Sent: Tuesday, February 10, 2026 9:02 AM
>> To: ZDI Disclosures Mailbox<zdi-disclosures@trendmicro.com>
>> Cc:ofono@lists.linux.dev;secalert@redhat.com;security@kernel.org
>> Subject: Re: ZDI-CAN-29089: New Vulnerability Report
>>
>> Hello,
>>
>> On Tue, Feb 10, 2026 at 04:54:46PM +0000,zdi-disclosures@trendmicro.com wrote:
>>> ZDI-CAN-29089: oFono MBIM SMS Handling Heap-based Buffer Overflow Arbitrary Code Execution Vulnerability
>>>
>>> -- CVSS -----------------------------------------
>>>
>>> 6.8: AV:P/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
>>>
>>> -- ABSTRACT -------------------------------------
>>>
>>> Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
>>> oFono - oFono
>>>
>>> -- VULNERABILITY DETAILS ------------------------
>>> * Version tested:20.0.3
>>> * Installerfile:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz
>>> * Platform tested:Raspberry Pi
>> (...)
>>
>> Please note that none of these 3 reports concern code in the Linux
>> kernel, sosecurity@kernel.org can be dropped from future exchanges.
>>
>> Thanks,
>> Willy
>> TREND MICRO EMAIL NOTICE
>> The information contained in this email and any attachments is confidential
>> and may be subject to copyright or other intellectual property protection.
>> If you are not the intended recipient, you are not authorized to use or
>> disclose this information, and we request that you notify us by reply mail or
>> telephone and delete the original message from your mail system.
>> For details about what personal information we collect and why, please see our Privacy Notice on our website at: [https://www.trendmicro.com/privacy]
>>
>>

--------------uOfmbM0by1jXN1c4vmLhn9LF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-03-12 13:13, Sicelo wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:abMecbIIvAhibdPv@tp440p.steeds.sam">
      <pre wrap="" class="moz-quote-pre">Community members will work on these. As with any other open-source
projects, patches welcome.</pre>
    </blockquote>
    <p>This looks a lot like a problem I encountered on a buggy modem in
      October and submitted a patch for.  I've re-attached the patch
      here, perhaps it was missed because I didn't submit it using git?</p>
    <p>Morgan Hughes</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:abMecbIIvAhibdPv@tp440p.steeds.sam">
      <pre wrap="" class="moz-quote-pre">



On Thu, Mar 12, 2026 at 07:13:20PM +0000, <a class="moz-txt-link-abbreviated" href="mailto:zdi-disclosures@trendmicro.com">zdi-disclosures@trendmicro.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hello Willy,

Noted thank you!

Any updates on this issue?

Thanks,
ZDI

-----Original Message-----
From: Willy Tarreau <a class="moz-txt-link-rfc2396E" href="mailto:w@1wt.eu">&lt;w@1wt.eu&gt;</a>
Sent: Tuesday, February 10, 2026 9:02 AM
To: ZDI Disclosures Mailbox <a class="moz-txt-link-rfc2396E" href="mailto:zdi-disclosures@trendmicro.com">&lt;zdi-disclosures@trendmicro.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:ofono@lists.linux.dev">ofono@lists.linux.dev</a>; <a class="moz-txt-link-abbreviated" href="mailto:secalert@redhat.com">secalert@redhat.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:security@kernel.org">security@kernel.org</a>
Subject: Re: ZDI-CAN-29089: New Vulnerability Report

Hello,

On Tue, Feb 10, 2026 at 04:54:46PM +0000, <a class="moz-txt-link-abbreviated" href="mailto:zdi-disclosures@trendmicro.com">zdi-disclosures@trendmicro.com</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">ZDI-CAN-29089: oFono MBIM SMS Handling Heap-based Buffer Overflow Arbitrary Code Execution Vulnerability

-- CVSS -----------------------------------------

6.8: AV:P/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
oFono - oFono

-- VULNERABILITY DETAILS ------------------------
* Version tested:20.0.3
* Installer <a class="moz-txt-link-freetext" href="file:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz">file:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz</a>
* Platform tested:Raspberry Pi
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">(...)

Please note that none of these 3 reports concern code in the Linux
kernel, so <a class="moz-txt-link-abbreviated" href="mailto:security@kernel.org">security@kernel.org</a> can be dropped from future exchanges.

Thanks,
Willy
TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidential
and may be subject to copyright or other intellectual property protection.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mail or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please see our Privacy Notice on our website at: [ <a class="moz-txt-link-freetext" href="https://www.trendmicro.com/privacy">https://www.trendmicro.com/privacy</a>]


</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------uOfmbM0by1jXN1c4vmLhn9LF--
--------------XRNfIUndevMGWEP8jBBh8lW0
Content-Type: text/x-patch; charset=UTF-8; name="mbim-header-validate.patch"
Content-Disposition: attachment; filename="mbim-header-validate.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWJpbW1vZGVtL21iaW0uYyBiL2RyaXZlcnMvbWJpbW1v
ZGVtL21iaW0uYwppbmRleCBjNDA1NzYxZC4uNDMyMmY1YWQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbWJpbW1vZGVtL21iaW0uYworKysgYi9kcml2ZXJzL21iaW1tb2RlbS9tYmltLmMKQEAg
LTE4LDYgKzE4LDcgQEAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogCiAjaW5jbHVkZSA8
ZWxsL2VsbC5oPgorI2luY2x1ZGUgPGVsbC91c2VmdWwuaD4KIAogI2luY2x1ZGUgIm1iaW0u
aCIKICNpbmNsdWRlICJtYmltLW1lc3NhZ2UuaCIKQEAgLTYxMyw2ICs2MTQsMTUgQEAgc3Rh
dGljIGJvb2wgY29tbWFuZF9yZWFkX2hhbmRsZXIoc3RydWN0IGxfaW8gKmlvLCB2b2lkICp1
c2VyX2RhdGEpCiAJaGRyID0gKHN0cnVjdCBtYmltX21lc3NhZ2VfaGVhZGVyICopIGRldmlj
ZS0+aGVhZGVyOwogCXR5cGUgPSBMX0xFMzJfVE9fQ1BVKGhkci0+dHlwZSk7CiAKKwlpZiAo
dW5saWtlbHkoaGRyLT5sZW4gPiBNQVhfQ09OVFJPTF9UUkFOU0ZFUikpIHsKKwkJY2hhciAq
aGV4ID0gbF91dGlsX2hleHN0cmluZyhkZXZpY2UtPmhlYWRlciwKKwkJCQkJCXNpemVvZihz
dHJ1Y3QgbWJpbV9tZXNzYWdlX2hlYWRlcikpOworCQlsX3dhcm4oIk1CSU06IHNraXAgaW1w
bGF1c2libGUgaGRyICVzOiBsZW4gMHgleCB0eXBlIDB4JXgiLCBoZXgsCisJCQlMX0xFMzJf
VE9fQ1BVKGhkci0+bGVuKSwgTF9MRTMyX1RPX0NQVShoZHItPnR5cGUpKTsKKwkJbF9mcmVl
KGhleCk7CisJCXJldHVybiBmYWxzZTsKKwl9CisKIAlpZiAoZGV2aWNlLT5zZWdtZW50X2J5
dGVzX3JlbWFpbmluZyA9PSAwKQogCQlkZXZpY2UtPnNlZ21lbnRfYnl0ZXNfcmVtYWluaW5n
ID0KIAkJCQkJTF9MRTMyX1RPX0NQVShoZHItPmxlbikgLQo=

--------------XRNfIUndevMGWEP8jBBh8lW0--
