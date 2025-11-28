Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9270F3595B
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317725; cv=none; b=KEToV6AXO/vIEnSQBmvjKnLR4ntGlJTcc0dW4oWHCREoy2CrIVI1n288Ufdo9JafdueVkn2APZeOuBXrStdo59/2ngmWPmNDeP08l0GywNP7lu6erAO8aGn/0srmx01XQRpxTxMpztmdWZDa7ufAcWaFMmQcv6BJVKeh6Wi8IP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317725; c=relaxed/simple;
	bh=Q9Xe8lEBuZ4nyhkj9pWdlloWddyhN5zcYAyEbCv2m/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Dyry5Dx+bedRQaHtQaEIdba9Y2TkNJh7tsczUWs1pdZc90IJIfD40s0hlju3qGIgnjLnVq8kVnCa5q5+Y3ow3WO9NEPRuffzK9o8xuO0+bZ2ULZhm8q4Y2VyTCVqfyooCIJCTVdBMh1VngctXk1n5ZJhD1ruI6Ih2S8gzvLdc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 4B0B8112B77; Fri, 28 Nov 2025 03:07:44 -0500 (EST)
Received: from [192.168.12.220] (unknown [172.56.167.181])
	by spindle.queued.net (Postfix) with ESMTPSA id CC9BD112B6A;
	Fri, 28 Nov 2025 03:07:43 -0500 (EST)
Message-ID: <5a7da914-5364-44cc-86f2-4206b487b91d@queued.net>
Date: Fri, 28 Nov 2025 03:07:42 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] plugins/udevng: Add support for PCIe MBIM modems
 * Parses through the sysfs tree and detects MBIM control nodes, net and AT
 nodes
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
 <20251127174946.89981-3-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
Cc: ofono <ofono@lists.linux.dev>
From: Andres Salomon <dilinger@queued.net>
In-Reply-To: <20251127174946.89981-3-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

Hi Muhammad!

On 11/27/25 12:49, Muhammad Asif wrote:
> ---
>   plugins/udevng.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 18954d44..bae0be76 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1186,7 +1186,13 @@ static gboolean setup_mbim(struct modem_info *modem)
>   {
>   	const char *ctl = NULL, *net = NULL, *atcmd = NULL;
>   	GSList *list;
> +	const char *sub_subsystem = NULL, *type = NULL;
> +	char path[512], wwan_path[1024], sub_path[2048];
>   	char descriptors[PATH_MAX];
> +	struct udev *new_udev;
> +	struct udev_device *wwan_device, *sub_device;
> +	struct dirent *dir = NULL, *subdir = NULL;
> +	DIR *d = NULL, *sd = NULL;
>   
>   	DBG("%s [%s:%s]", modem->syspath, modem->vendor, modem->model);
>   
> @@ -1206,6 +1212,56 @@ static gboolean setup_mbim(struct modem_info *modem)
>   		else if (g_strcmp0(subsystem, "tty") == 0) {
>   			if (g_strcmp0(info->number, "02") == 0)
>   				atcmd = info->devnode;
> +		} else if (g_strcmp0(subsystem, "pci") == 0) {
> +			sprintf(path, "%s/wwan", udev_device_get_syspath(info->udev_device));

This about doubles the size of the function. I would suggest creating a 
new function (with a comment!) for traversing the subdirectories.

My understanding of this function is that if your modem has a "pci" 
directory, you're looking at pci/*/* where subsystem == wwan, and type 
== MBIM or AT. But a comment would help example that.



> +
> +			d = opendir(path);
> +			if (!d)
> +				return FALSE;
> +
> +			new_udev = udev_new();

This can fail, and you should probably check for NULL here.


> +
> +			while ((dir = readdir(d))) {
> +				if (g_strcmp0(dir->d_name, ".") == 0 ||
> +					g_strcmp0(dir->d_name, "..") == 0)
> +					continue;
> +

Glib provides wrappers for walking a directory:
<https://docs.gtk.org/glib/file-utils.html>
I suggest using g_dir_open() and friends instead of readdir(), etc. For 
example, g_dir_read_name skips over '.' and '..' already. You can see 
usage of it in src/plugin.c.

In addition, you've got some buffers above that may or may not be okay 
depending on what's in sysfs; I would assume you wouldn't normally hit 
PATH_MAX and overflow the buffer, but it'd be safer to just allocate 
memory using g_build_filename(), g_strconcat(), or similar.


> +				sprintf(wwan_path, "%s/%s", path, dir->d_name);
 > +> +				wwan_device = udev_device_new_from_syspath(new_udev,
> +									wwan_path);

This can also fail, and NULL should be checked for. Same issue below for 
sub_device.


> +				net = udev_device_get_sysname(wwan_device);
> +
> +				/* Parse all the subdirectories now */
> +				sd = opendir(wwan_path);
> +				while ((subdir = readdir(sd))) {
> +					if (subdir->d_type != DT_DIR)
> +						continue;
> +

If you decide to use GDir, here you'd do something like:
sub_path = g_build_filename(wwan_path, subdir, NULL);
if (g_file_test(sub_path, G_FILE_TEST_IS_DIR)) {
   g_free(sub_path);
   continue;
}


> +					if (g_strcmp0(subdir->d_name, ".") == 0 ||
> +						g_strcmp0(subdir->d_name, "..") == 0)
> +						continue;
> +
> +					sprintf(sub_path, "%s/%s", wwan_path, subdir->d_name);
> +
> +					sub_device = udev_device_new_from_syspath(new_udev,
> +										sub_path);
> +					sub_subsystem = udev_device_get_subsystem(sub_device);
> +
> +					if (g_strcmp0(sub_subsystem, "wwan") == 0) {
> +						type = udev_device_get_sysattr_value(sub_device, "type");
> +
> +						if (g_strcmp0(type, "MBIM") == 0)
> +							ctl = udev_device_get_devnode(sub_device);
> +						else if (g_strcmp0(type, "AT") == 0)
> +							atcmd = udev_device_get_devnode(sub_device);
> +					}

sub_device should be udev_device_unref'd here, otherwise it's leaked.

> +				}
> +				closedir(sd);

wwan_device should be udev_device_unref'd here, as well.


> +				break;
> +			}
 > +			closedir(d);> +			udev_unref(new_udev);
 >   		}>   	}
>   

