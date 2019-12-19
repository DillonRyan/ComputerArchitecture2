import java.util.ArrayList;
import java.util.List;

public class CacheTutorial {
	static String[] inputs = { "0000", "0010", "0020", "0030", "003c", "0050", "0010", "000c", "0010", "0050", "002c", "0010",
			"0050", "0020", "0010", "0000" };

	public static void main(String[] args) {
		List<Cache> cache = new ArrayList<Cache>();
		cache.add(new Cache(16, 4, 1));
		//cache.add(new Cache(16, 4, 2));
		//cache.add(new Cache(16, 2, 4));
		//cache.add(new Cache(16, 1, 8));
		for (Cache caches : cache) {
			int count = 0;
			int misses = 0;
				for(int i = 0; i < inputs.length;i++) {
				if (!caches.check(inputs[i])) {
					misses++;
				} else {
					count++;
				}
			}
			System.out.println("L=" + caches.LineSize + ", N=" + caches.NumOfSets + ", K=" + caches.NumOfTagsK + ": "
					+ count + " hits " + misses + " Misses");
		}
	}
}

class Cache {
	int LineSize;
	int NumOfSets;
	int NumOfTagsK;
	List<Set> sets = new ArrayList<Set>();

	Cache(int LineSize, int NumOfSets, int NumOfTagsK) {
		this.LineSize = LineSize;
		this.NumOfSets = NumOfSets;
		this.NumOfTagsK = NumOfTagsK;
		for (int i = 0; i < NumOfSets; i++)
			sets.add(i, new Set(NumOfTagsK));
	}

	boolean check(String s) {
		int address = (int) Long.parseLong(s, 16);
		int setno = (address >> 4) & ((1 << (int) (Math.log(NumOfSets) / Math.log(2))) - 1);
		int tag = address >> ((int) (Math.log(NumOfSets) / Math.log(2)) + 4);
		return sets.get(setno).check(tag);
	}
}

class Set {
	List<Tag> tags = new ArrayList<Tag>();
	int KTags, timestamp;

	Set(int K) {
		this.KTags = KTags;
		this.timestamp = 0;
		for (int i = 0; i < K; i++)
			tags.add(i, new Tag());
	}

	public boolean check(int tag) {
		timestamp++;
		int index = -1;
		for (int i = 0; i < tags.size(); i++) {
			if (tags.get(i).val == tag) {
				index = i;
				break;
			}
		}
		if (index >= 0) {
			Tag t = tags.get(index);
			t.timestamp = timestamp;
			return true;
		} else {
			int oldest = 0;
			int t = Integer.MAX_VALUE;
			for (int i = 0; i < tags.size(); i++) {
				if (tags.get(i).timestamp < t) {
					oldest = i;
					t = tags.get(i).timestamp;
				}
			}
			tags.get(oldest).val = tag;
			tags.get(oldest).timestamp = timestamp;
		}
		return false;
	}
}

class Tag {
	int val, timestamp;

	Tag() {
		val = -1;
		timestamp = 0;
	}
}
