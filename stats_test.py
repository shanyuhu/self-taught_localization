import unittest
import bbox
import stats

class StatsTest(unittest.TestCase):
    def setUp(self):
        # image 1
        self.gt_bboxes = {'dog':[bbox.BBox(0.1, 0.1, 0.3, 0.3, 1.0), \
                                 bbox.BBox(0.4, 0.4, 0.7, 0.9, 1.0)]}
        self.pred_bboxes = {'dog':[bbox.BBox(0.1, 0.1, 0.3, 0.35, 3.1), \
                                   bbox.BBox(0.2, 0.3, 0.5, 0.6, 1.1), \
                                   bbox.BBox(0.4, 0.4, 0.75, 0.85, 0.4)]}
        # image 2 (same class)
        self.gt_bboxes2 = {'dog':[bbox.BBox(0.0, 0.0, 0.2, 0.2, 1.0), \
                                  bbox.BBox(0.4, 0.0, 0.6, 0.2, 1.0),
                                  bbox.BBox(0.4, 0.6, 0.8, 1.0, 1.0)]}
        self.pred_bboxes2 = {'dog':[bbox.BBox(0.0, 0.0, 0.1, 0.2, 1.1), \
                                    bbox.BBox(0.5, 0.7, 0.65, 0.85, 1.22)]}
 

    def tearDown(self):
        self.gt_bbox = None
        self.pred_bbox = None

    def test_stats(self):
        stat_single = stats.Stats()
        stat_single.compute_stats(self.pred_bboxes['dog'], \
                                  self.gt_bboxes['dog'])
        self.assertAlmostEqual(stat_single.overlap[0], 0.8, places=5)
        self.assertAlmostEqual(stat_single.overlap[1], 0.0909090, places=5)
        self.assertAlmostEqual(stat_single.overlap[2], 0.7826087, places=5)
        self.assertEqual(stat_single.TP[0], 1)
        self.assertEqual(stat_single.TP[1], 0)
        self.assertEqual(stat_single.TP[2], 1)
        self.assertEqual(stat_single.FP[0], 0)
        self.assertEqual(stat_single.FP[1], 1)
        self.assertEqual(stat_single.FP[2], 0)
        self.assertEqual(stat_single.NPOS, 2)
        print str(stat_single)

    def test_aggregator(self):
        stats_list = []
        stat_1 = stats.Stats()
        stat_1.compute_stats(self.pred_bboxes['dog'], self.gt_bboxes['dog'])
        stat_2 = stats.Stats()
        stat_2.compute_stats(self.pred_bboxes2['dog'], self.gt_bboxes2['dog'])
        stats_list.append(stat_1)
        stats_list.append(stat_2)
        stats_aggr, hist_overlap = stats.Stats.aggregate_results(stats_list)
        print str(stats_aggr) 
        self.assertEqual(stats_aggr.NPOS, 5)
        self.assertEqual(stats_aggr.TP[0], 1)
        self.assertEqual(stats_aggr.TP[1], 0)
        self.assertEqual(stats_aggr.TP[2], 1)
        self.assertEqual(stats_aggr.TP[3], 1)
        self.assertEqual(stats_aggr.TP[4], 0)
        self.assertAlmostEqual(stats_aggr.overlap[0], 0.8, places = 5)
        self.assertAlmostEqual(stats_aggr.overlap[1], 0.0909090, places = 5)
        self.assertAlmostEqual(stats_aggr.overlap[2], 0.7826086, places = 5)   
        self.assertAlmostEqual(stats_aggr.overlap[3], 0.5, places = 5)
        self.assertAlmostEqual(stats_aggr.overlap[4], 0.140625, places = 5)
        self.assertAlmostEqual(stats_aggr.precision[0], 0.2, places = 3)
        self.assertAlmostEqual(stats_aggr.precision[1], 0.2, places = 3)
        self.assertAlmostEqual(stats_aggr.precision[2], 0.4, places = 3)
        self.assertAlmostEqual(stats_aggr.precision[3], 0.6, places = 3)
        self.assertAlmostEqual(stats_aggr.precision[4], 0.6, places = 3)
        self.assertAlmostEqual(stats_aggr.recall[0], 1.0, places = 3)
        self.assertAlmostEqual(stats_aggr.recall[1], 0.5, places = 3)
        self.assertAlmostEqual(stats_aggr.recall[2], 0.6666667, places = 5)
        self.assertAlmostEqual(stats_aggr.recall[3], 0.75, places = 3)
        self.assertAlmostEqual(stats_aggr.recall[4], 0.6, places = 3) 
        self.assertAlmostEqual(stats_aggr.detection_rate, 0.6, places = 3) 
        self.assertAlmostEqual(stats_aggr.average_prec, 0.490909, places = 5) 
        self.assertEqual(hist_overlap[0][0], 1)
        self.assertEqual(hist_overlap[0][1], 1)
        self.assertEqual(hist_overlap[0][6], 0)

#==============================================================================

if __name__ == '__main__':
    unittest.main()
